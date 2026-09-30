# Git workflow for Malinkaos

A beginner-friendly guide to how this repository uses git and GitHub.

## The basic ideas

| Word | What it means |
|---|---|
| **Repository (repo)** | The project folder plus its whole history. Git stores the history in the hidden `.git/` folder. |
| **Commit** | A saved snapshot of the project, with a message that explains the change. |
| **Branch** | A separate line of work. You can experiment on a branch without touching `main`. |
| **`main`** | The main branch. It should always contain working code. |
| **Remote (`origin`)** | The copy of the repo on GitHub. |
| **Push / pull** | Push sends your commits to GitHub. Pull fetches new commits from GitHub. |
| **Pull request (PR)** | A request on GitHub to merge a branch into `main`. CI runs the checks on it before you merge. |
| **Tag** | A permanent name for a specific commit, used to mark releases (e.g. `v0.1.0`). |

Git only saves what you tell it to, in two steps:

```
edit files  →  git add (stage)  →  git commit (save snapshot)  →  git push (upload)
```

## Branch model

- `main` is always working. You don't commit directly to it.
- Every change gets its own short-lived branch, created from `main`:
  - `feature/<name>` for new functionality, e.g. `feature/project-database`
  - `fix/<name>` for bug fixes, e.g. `fix/dashboard-overflow`
  - `docs/<name>`, `refactor/<name>` or `chore/<name>` for other work
- When the work is done, open a pull request, wait for the green CI check, then merge it and delete the branch.

## Day-to-day loop

```bash
# 1. Start from an up-to-date main
git switch main
git pull

# 2. Create a branch for your change
git switch -c feature/project-details

# 3. Work, then check what changed
git status          # which files changed
git diff            # the exact line changes

# 4. Stage and commit (you can do this several times)
git add .
git commit -m "feat: show project details page"

# 5. Upload the branch (-u only needed the first time)
git push -u origin feature/project-details
```

Then on GitHub:

1. Click **Compare & pull request**.
2. Wait for the **CI** check to turn green.
3. Click **Merge pull request**, then **Delete branch**.

Finally, clean up locally:

```bash
git switch main
git pull
git branch -d feature/project-details
```

## Commit messages

We use [Conventional Commits](https://www.conventionalcommits.org): a type, a colon, then a short description in the present tense.

| Type | Use for |
|---|---|
| `feat:` | a new feature |
| `fix:` | a bug fix |
| `docs:` | documentation only |
| `refactor:` | code change that doesn't change behaviour |
| `test:` | adding or changing tests |
| `chore:` | tooling, config, dependencies |

Examples: `feat: load projects from database`, `fix: prevent card overflow on small screens`.

## Versioning and releases

Versions follow [semantic versioning](https://semver.org): `MAJOR.MINOR.PATCH`.

- **PATCH** (`0.1.0 → 0.1.1`): bug fixes only
- **MINOR** (`0.1.0 → 0.2.0`): new features
- **MAJOR** (`0.x → 1.0.0`): a big or breaking change, e.g. the first "real" release

The version lives in `pubspec.yaml` as `version: 0.1.0+1`. The part after `+` is the build number, which app stores require to increase with every upload.

To make a release (done on `main` after merging):

1. Move the items under `## [Unreleased]` in `CHANGELOG.md` into a new version section.
2. Bump `version:` in `pubspec.yaml`.
3. Commit, tag and push:

```bash
git commit -am "chore: release v0.2.0"
git tag -a v0.2.0 -m "Version 0.2.0"
git push
git push --tags
```

4. Optional: on GitHub, go to **Releases → Draft a new release**, pick the tag and paste the changelog notes.

## Fixing common mistakes

| Problem | Command |
|---|---|
| Undo changes to a file you haven't committed | `git restore <file>` |
| Unstage a file (keep the changes) | `git restore --staged <file>` |
| Fix the message of the last commit (not pushed yet) | `git commit --amend -m "new message"` |
| Undo the last commit but keep the changes (not pushed yet) | `git reset --soft HEAD~1` |
| Undo a commit that is already pushed | `git revert <commit-id>` (creates a new commit that undoes it) |
| Put unfinished work aside to switch branch | `git stash`, and later `git stash pop` |
| See the history | `git log --oneline --graph --all` |

Rule of thumb: once a commit is pushed, fix it with a **new** commit (`revert`), not by rewriting history.
