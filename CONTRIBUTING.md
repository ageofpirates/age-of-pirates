# Contributing to Age of Pirates

## 1. Setup

1. [Download the setup script](https://cdn.discordapp.com/attachments/679041670775570466/1147233508595597523/aop_setup.ps1). You can [check the script's contents here](https://gist.github.com/ageofpirates/584105a0f6f306c427da9236bf0a1f70) if you want to make sure it's safe.
2. Run Powershell as administrator.
3. Execute the following commands one by one (replace `C:\Users\Alice\Downloads` with the path to the folder where you downloaded the setup script):
```powershell
# Get the execution policy.
$policy = Get-ExecutionPolicy -Scope CurrentUser
# Temporarily set the execution policy to unrestricted.
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
# Run the setup script.
Set-Location "C:\Users\Alice\Downloads" # Replace this with the path to the folder where you downloaded the setup script.
.\aop_setup.ps1
# Restore the execution policy.
Set-ExecutionPolicy -ExecutionPolicy $policy -Scope CurrentUser
```

## 2. Contributing code

### 2.1. General

#### 2.1.1. What is this repository for?

The repository is strictly reserved for operations that we all know for sure are going to be in the next release or any future release. Such operations are:
- bug reports, feature requests, and feedback in the form of [issues](https://github.com/ageofpirates/age-of-pirates/issues)
- bug fixes
- refactoring
- maintenance (for example: the main game's AI gets updated and we move the mod's changes to that new version)
- removing old unused files and/or code
- adding new features and/or content
- adding new translations

#### 2.1.2. What is this repository NOT for?

If you would like to experiment with something for testing purposes, out of pure curiosity, "just for fun", or for any other reason, please refrain from pushing your changes to the remote repository &mdash; you can do whatever you want in your local repository as long as the remote repository is not affected.

If you would like to share your experiments with the rest of the team, you can do so by multiple means:
- if you want to share code, you are highly encouraged to use GitHub's [Gists feature](https://gist.github.com/).
- if you want to share files, you can either send them on Discord or use whatever you're comfortable with (for example: Google Drive, Dropbox, etc.)
- if you want to share your thoughts, ideas, or anything else, you can do so on Discord.

You can also use other means but *__keep the remote repository clean, please__*.

#### 2.1.3. Exceptions to the above rules

Long running work-in-progress stuff should be kept in separate branches prefixed with `wip/` (for example: `wip/ai-rewrite`). Once the work is done and fully tested, it should be merged into the `main` branch and the corresponding `wip/` branch should be deleted immediately (for example: `wip/ai-rewrite` should be deleted after merging it into `main`).

### 2.2. Workflow

Here's a quick overview of the workflow:
1. A team member called "Alice" picks up a task to work on, for example: "fix the bug with the AI not migrating to the big island".
2. Alice opens her local repository and executes the following commands:
```bash
git checkout main                 # Alice switches to the main branch.
git pull                          # Alice pulls the latest changes from the remote repository.
git checkout -b fix/ai-migration  # Alice creates a new branch from the main branch.
```
3. Alice does her work on the `fix/ai-migration` branch.
4. Alice tests her work and makes sure everything works as intended.
5. Alice commits her changes to the `fix/ai-migration` branch:
```bash
git add .                         # Alice adds all the changes she made to the staging area.
git commit -m "Fix AI migration"  # Alice commits her changes to the local repository.
```
6. Alice pushes her commits to the remote repository:
```bash
git push origin fix/ai-migration  # Alice pushes her commits to the remote repository.
```
7. Alice goes to GitHub to [create a pull request](https://github.com/ageofpirates/age-of-pirates/compare) from the `fix/ai-migration` branch to the `main` branch: `base: main` &larr; `compare: fix/ai-migration`
8. BaltazarGreat (the project leader) or any other team member reviews the pull request and either approves it or requests changes.
9. If the pull request is approved, the project leader or any other team member merges it into the `main` branch.
10. The `fix/ai-migration` branch is deleted immediately after merging it into the `main` branch.

On top of that, the following rules apply:
- the `main` branch is protected, meaning that no one can push directly to it &mdash; all changes must go through pull requests.
- a branch and its changes must be specific to a single task or multiple closely related tasks &mdash; for example, a branch named `fix/ai-migration` should only contain changes related to fixing the AI migration bug.
- in case you want to complete multiple tasks that are not closely related, you should create a separate branch for each task &mdash; for example, if you want to fix the AI migration bug and add a new map, you should create two branches: `fix/ai-migration` and `content/hispaniola-map`.
- a branch must be deleted immediately after merging it into the `main` branch.

## 3. Other means of contributing

If you don't have any modding knowledge or experience, you can still contribute by:
- joining us on [Discord](https://discord.gg/pcD4XfHZah)
- talking about the mod on social media
- sharing the mod with your friends
- providing feedback
- reporting bugs
- requesting features
- translating the mod into your native language
