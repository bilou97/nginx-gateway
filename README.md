# nginx-gateway

Reverse proxy central pour papobilou.ch. Gère le SSL (Let's Encrypt) et le routing vers les différents projets Docker de la VM.

## Domaines configurés

| Domaine | Projet |
|---|---|
| actual.papobilou.ch | actual/ |
| blog.papobilou.ch | personal_blog/ |

## Architecture

```
Internet (80/443)
    └── nginx-gateway
            ├── actual.papobilou.ch  → réseau actual_default  → actual:5006
            └── blog.papobilou.ch   → réseau personal_blog_default → frontend/backend
```

## Prérequis

- Les projets `actual` et `personal_blog` doivent être démarrés avant le gateway
- Les réseaux Docker `actual_default` et `personal_blog_default` doivent exister

## Première installation

```bash
# 1. Obtenir les certificats SSL (un par domaine)
bash scripts/init-ssl.sh actual.papobilou.ch ton@email.com
bash scripts/init-ssl.sh blog.papobilou.ch ton@email.com

# 2. Démarrer le gateway complet
docker compose up -d
```

## Ajouter un nouveau domaine

1. Créer `nginx/conf.d/<nouveau-domaine>.conf`
2. Ajouter le réseau du projet dans `docker-compose.yml`
3. Obtenir le certificat : `bash scripts/init-ssl.sh nouveau-domaine.ch email`
4. `docker compose up -d`

## Mise à jour

```bash
git pull
docker compose up -d
```
