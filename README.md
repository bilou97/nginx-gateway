# caddy-gateway

Reverse proxy central pour papobilou.ch. Caddy gère automatiquement le SSL via Let's Encrypt.

## Domaines configurés

| Domaine | Projet |
|---|---|
| actual.papobilou.ch | actual/ |
| blog.papobilou.ch | personal_blog/ |

## Architecture

```
Internet (80/443)
    └── caddy-gateway
            ├── actual.papobilou.ch  → réseau actual_default  → actual:5006
            └── blog.papobilou.ch   → réseau personal_blog_default → frontend/backend
```

## Prérequis

- Les projets `actual` et `personal_blog` doivent être démarrés avant le gateway
- Les réseaux Docker `actual_default` et `personal_blog_default` doivent exister
- Les DNS `actual.papobilou.ch` et `blog.papobilou.ch` pointent vers l'IP de la VM

## Démarrage

```bash
# S'assurer que les autres projets tournent d'abord
# cd ~/actual && docker compose up -d
# cd ~/personal_blog && docker compose up -d

# Lancer le gateway (Caddy obtient les certs SSL automatiquement)
docker compose up -d
```

## Ajouter un nouveau domaine

1. Ajouter un bloc dans `Caddyfile`
2. Ajouter le réseau du projet dans `docker-compose.yml`
3. `docker compose up -d` — Caddy obtient le cert tout seul

## Mise à jour

```bash
git pull
docker compose up -d
```
