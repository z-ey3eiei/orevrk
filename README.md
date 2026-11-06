# orevrk.cloud

Static site with [Cloudflare Pages](https://pages.cloudflare.com/) and **Pages Functions** under `/api/*`.

## Deploy

`CLOUDFLARE_API_TOKEN` must belong to the **same Cloudflare account** that owns the DNS zone for `orevrk.cloud`, and it needs **Pages** edit permissions.

```bash
npm install
export CLOUDFLARE_ACCOUNT_ID=<account_id_that_owns_orevrk.cloud>
npx wrangler pages project create orevrk-cloud --production-branch=main   # once only
npx wrangler pages deploy . --project-name=orevrk-cloud
```

### Custom domain

In [Cloudflare Dashboard](https://dash.cloudflare.com/) → **Workers & Pages** → project **orevrk-cloud** → **Custom domains** → add `orevrk.cloud` and `www.orevrk.cloud`. The zone must live in that same account (or you must use the account where your Pages project is deployed and point DNS accordingly).

## API (Pages Functions)

- `GET /api/hello` — JSON greeting
- `GET /api/health` — health check

---

[![Netlify Status](https://api.netlify.com/api/v1/badges/fe6e4a93-3ddf-49b5-8eb0-5fb8b22fe974/deploy-status)](https://app.netlify.com/projects/orevrk/deploys)
