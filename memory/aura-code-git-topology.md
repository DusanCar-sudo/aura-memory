---
name: aura-code-git-topology
description: aura-code local master and GitHub master (remote "dusancar") have diverged; a git-lfs pre-push hook blocks pushes without git-lfs
metadata:
  type: project
---

State as of 2026-09-24, repo `/mnt/bigdata/aura/aura-code`:
- **Remotes and branches.** The GitHub remote is `dusancar` (DusanCar-sudo/aura-code, public, default branch `master`). Local `master` (98b6978) and `dusancar/master` have diverged, and each side has commits the other lacks. `learning-journey` is built on local master and has not been pushed.
- **Other session's work.** The main working tree has another session's large uncommitted theme refactor. Build anything meant for GitHub in a `git worktree` off `dusancar/master` and push as a fast-forward. Symlink `node_modules` in, then `unlink` it before `git worktree remove`.
- **Push hook.** `.git/hooks/pre-push` is a git-lfs hook. `git-lfs` isn't installed and the repo has no `.gitattributes`, so every push fails with exit 2. Use `git push --no-verify`, or install git-lfs, which needs the sudo password. The post-checkout and post-commit lfs hooks only print a warning, but they make `git worktree add`, `git checkout <rev> -- file` and `git commit` exit nonzero even though the command worked. Check `git status` instead of trusting `&&` chains. (2026-09-24: README restore 6fa7733 pushed this way.)
- **Installed CLI.** `/usr/lib/node_modules/aura-code` is a real directory built from local master, not a symlink. One changed file can be swapped into `dist/` when its source is identical at that commit.

**Why:** found while pushing the retro banner ([[aura-retro-design]]). Pushing local master would have published other sessions' unpushed work, and the hook failure looks like a network error.

**How to apply:** fetch first and check `git rev-list --left-right --count dusancar/master...<branch>`. Never push local master or learning-journey without asking. See also [[aura-surface-confusion]].
