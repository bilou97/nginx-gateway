# caddy-gateway

Reverse proxy central pour papobilou.ch. Caddy gère automatiquement le SSL via Let's Encrypt.

## Domaines configurés

| Domaine | Projet |
|---|---|
| actual.papobilou.ch | actual/ |
| blog.papobilou.ch | personal_blog/ |
| floorball.papobilou.ch | luc_floorball/ |

## Architecture

```
Internet (80/443)
    └── caddy-gateway
            ├── actual.papobilou.ch    → réseau actual-budget_default → actual:5006
            ├── blog.papobilou.ch      → réseau blog_default          → web:80
            └── floorball.papobilou.ch → réseau luc_floorball_default → nginx:80
```

## Prérequis

- Les projets `actual`, `personal_blog` et `luc_floorball` doivent être démarrés avant le gateway (profil `prod` pour `luc_floorball`)
- Les réseaux Docker `actual-budget_default`, `blog_default` et `luc_floorball_default` doivent exister
- Les DNS `actual.papobilou.ch`, `blog.papobilou.ch` et `floorball.papobilou.ch` pointent vers l'IP de la VM

## Démarrage

```bash
# S'assurer que les autres projets tournent d'abord
# cd ~/actual && docker compose up -d
# cd ~/personal_blog && docker compose -f docker-compose.yml -f docker-compose.prod.yml -p blog up -d
# cd ~/luc_floorball && docker compose up -d

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
