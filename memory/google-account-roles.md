---
name: google-account-roles
description: milodule3@gmail.com is the main account for accounts/signups; leanproiq@gmail.com is for files and backups
metadata: 
  node_type: memory
  type: user
  originSessionId: 8ec0e1ff-18e9-489f-b6fb-852cfad953a5
  modified: 2026-09-29T08:21:32.120Z
---

Dusan runs two Google accounts with a deliberate split:

- **milodule3@gmail.com** — the MAIN account. Use it for signing up to services,
  creating accounts, registrations, identity.
- **leanproiq@gmail.com** — files and backups. Drive storage, documents, backup
  targets. Also the account behind [[leanproiq-deploy]] (leanproiq.com).

**Why:** keeps identity/signups separate from the bulk file storage, so a problem with
one doesn't take the other down.

**How to apply:** when a task needs a Google account, pick by role rather than asking —
signup/registration → milodule3; anything storing, syncing or backing up files → leanproiq.
Both are signed into Chrome already (leanproiq is `authuser=1`), so switching needs no
password. For Hermes's Google Workspace skill Dusan chose leanproiq as the live account
(see [[hermes-python-ownership-fix]]).
