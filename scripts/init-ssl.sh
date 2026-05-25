#!/bin/bash
# Obtenir un certificat Let's Encrypt pour un domaine.
# Usage : bash scripts/init-ssl.sh <domain> <email>
# Exemple : bash scripts/init-ssl.sh blog.papobilou.ch admin@exemple.com
set -e

DOMAIN="${1:?Usage: $0 <domain> <email>}"
EMAIL="${2:?Usage: $0 <domain> <email>}"

# Démarrer nginx seul (HTTP uniquement pour le challenge ACME)
docker compose up -d nginx

# Attendre que nginx soit prêt
sleep 2

# Obtenir le certificat
docker compose run --rm certbot certbot certonly \
  --webroot -w /var/www/certbot \
  -d "$DOMAIN" \
  --email "$EMAIL" \
  --agree-tos --no-eff-email

# Recharger nginx avec SSL actif
docker compose exec nginx nginx -s reload

echo ""
echo "Certificat obtenu pour $DOMAIN."
echo "Si tous les domaines sont configurés, lance : docker compose up -d"
