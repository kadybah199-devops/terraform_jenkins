#!/bin/bash
set -e

# ─────────────────────────────────────────
# 1. Mise à jour du système
# ─────────────────────────────────────────
apt-get update -y
apt-get upgrade -y

# ─────────────────────────────────────────
# 2. Installation des dépendances
# ─────────────────────────────────────────
apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  apt-transport-https \
  software-properties-common

# ─────────────────────────────────────────
# 3. Ajout du dépôt officiel Docker
# ─────────────────────────────────────────
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# ─────────────────────────────────────────
# 4. Installation de Docker
# ─────────────────────────────────────────
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# ─────────────────────────────────────────
# 5. Installation de Docker Compose
# ─────────────────────────────────────────
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

# ─────────────────────────────────────────
# 6. Démarrage et activation de Docker
# ─────────────────────────────────────────
systemctl start docker
systemctl enable docker

# Ajouter l'utilisateur ubuntu au groupe docker
usermod -aG docker ubuntu

# ─────────────────────────────────────────
# 7. Création du dossier Jenkins
# ─────────────────────────────────────────
mkdir -p /opt/jenkins

# ─────────────────────────────────────────
# 8. Création du fichier docker-compose.yml
# ─────────────────────────────────────────
cat <<'EOF' > /opt/jenkins/docker-compose.yml
version: '3.8'

services:
  jenkins:
    image: jenkins/jenkins:lts
    container_name: jenkins
    restart: unless-stopped
    privileged: true
    user: root
    ports:
      - "8080:8080"     # Interface web Jenkins
      - "50000:50000"   # Communication avec les agents Jenkins
    volumes:
      - jenkins_home:/var/jenkins_home          # Persistance des données Jenkins
      - /var/run/docker.sock:/var/run/docker.sock  # Accès Docker depuis Jenkins
    environment:
      - JAVA_OPTS=-Djenkins.install.runSetupWizard=false

volumes:
  jenkins_home:
    driver: local
EOF

# ─────────────────────────────────────────
# 9. Lancement de Jenkins avec Docker Compose
# ─────────────────────────────────────────
cd /opt/jenkins
docker-compose up -d

# ─────────────────────────────────────────
# 10. Attente du démarrage de Jenkins
# ─────────────────────────────────────────
echo "Attente du démarrage de Jenkins..."
sleep 30

# ─────────────────────────────────────────
# 11. Récupération des métadonnées AWS
# ─────────────────────────────────────────
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
PUBLIC_DNS=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)

# ─────────────────────────────────────────
# 12. Sauvegarde dans jenkins_ec2.txt
# ─────────────────────────────────────────
cat <<EOF > /home/ubuntu/jenkins_ec2.txt
===== Jenkins Server Information =====
Public IP Address : $PUBLIC_IP
Public DNS        : $PUBLIC_DNS
Jenkins URL       : http://$PUBLIC_IP:8080
Jenkins DNS URL   : http://$PUBLIC_DNS:8080
Deployed at       : $(date)
=======================================
EOF

echo "✅ Jenkins déployé avec succès !"
echo "👉 Accès : http://$PUBLIC_IP:8080"