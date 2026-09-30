---
name: leanproiq-deploy
description: "leanproiq.com = Vercel project aura-water (not \"v2\"); CLI deploy from repo root drops all images via .vercelignore"
metadata: 
  node_type: memory
  type: reference
  originSessionId: e4ada8bd-b76c-4255-b296-44ff3cbb25d0
  modified: 2026-09-18T08:31:34.242Z
---

leanproiq.com / www.leanproiq.com are served by Vercel project **aura-water**
(team dusan-s-projects369, root directory `site`), deployed by CLI, not git.
`/mnt/bigdata/aura/aura-code/.vercel` links to a project "v2" that doesn't
serve the domain — deploying from there changes nothing live.

Trap (2026-09-18): the aura-code repo's `.vercelignore` excludes `*.png`/`*.jpg`,
so `vercel deploy --prod` from the repo root ships the site without images
(hero broke for ~3 min). Working recipe: copy `site/` to a clean dir, put
vercel.json (cleanUrls + headers, minus outputDirectory) inside it, then
`npx vercel deploy --prod --project aura-water --scope dusan-s-projects369`.
Vercel CLI 59 needs `deploy --prod`, bare `--prod` errors.

Since 2026-09-24 the homepage is the ∞K retro page, built by
`python3 site/build.py --home DIR` in ~/Projects/aura-retro-design ([[aura-retro-design]])
and committed into aura-code `site/`. Deploy from a commit, not the working tree
(other sessions leave uncommitted work there): `git -C $R archive HEAD site | tar -x -C $D`,
then vercel.json with `jq 'del(.outputDirectory,.buildCommand,.installCommand,.framework)'`
into `$D/site/`, then deploy from `$D`. Rollback target: aura-water-et6435e38 (pre-retro).

**/ados** (2026-09-24) is the Aura adOS page. It is built by `build.py --ados DIR` into aura-code `site/ados/`.
- `vercel.json` has `trailingSlash: false`, so `/ados` resolves relative URLs against `/`. Every asset URL on a sub-page must be absolute.
- Production is aura-water-udmlbljuu.
- To drop only the adOS page, roll back to k4n4fcgrw.
