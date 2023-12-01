# What is Git

Git areas:
- Working area: directory with an initialised git-project, where the changing of the project files are not yet tracked; 
- Staging area: area with tracked files, where snapshots of the files are added with the command `git add` or removed with `git reset`. This area is needed for preparing a commit;
- Local repository: area where commits are located. All changes to the project files that were added to the staging area will go to the local repository with the command `git commit`
- Remote repository: area in a cloud repository, such as GitHub, Bitbucket, or GitLab. 

<img src="git-areas.png">

# Basic commands

```bash
### Check Git version
git --version
### Check git credentials
git config -l
git config --list
git config --global user.name # user.email

### Configure the credentials
git config --global user.name "username-to-add"
```

# Overall pipeline

- `git init` or `git clone <https> <path to install to>` 
- `git add .`
- `git commit -m "commit message"`
- `git push`

There are a couple of starting points for using Git in your project:
1. Starting Git tracking from the local computer and then pushing to Github.
2. Starting the tracking and activity from within Github.

Let’s start with exploring the first option. **I create a project on my local computer, initialize tracking, then create a repository on Github and push my project there**. The main steps are as follows:

- Create a repository on my local machine and edit the files to be your first version
- Initialise Git tracking from the local machine: `git init`. Changes can be viewed with `git status`
- Add changes to staging/tracking: `git add .`
- Commit the changes, meaning that the changes will be added as a version to Git system: `git commit -m "message goes here"`
- Now the changes have been saved as per the Git system! The commit history can be checked with `git log --oneline`, showing one version per line, or with a tag `-1` to show only the last version. Additionally, differences and alterations can be checked with `git diff`
- Create a repository on Github and copy the HTTPS link;
- In the local repository, use Git to set the origin of Git as the remote repository on Github: `git remote add origin [https]`
- Finally, push the changes to the previously set origin: `git push --set-upstream origin master`


The second option implies that the initial version are already on Github, perhaps because you worked on them before or if you created the files directly on Github. **To clone a repository from Github**, you can use the command `git clone [ssh / https address]`. Cloning is bringing a repository hosted on Github to your local PC. You can use SSH or HTTPS, depending on which one works for you. If you already have a repository from Github, but the one on Github has changes that weren’t updated on the local PC, we can update local repo from the latest changes in Github with `git pull`.

# Working with branches

I rarely use branches in my Git version control. This feature can be useful to create different branches from a chosen version, to perhaps explore different ways to edit the code.

- Show branches: `git branch -a`
- Delete a branch: `git branch -d branchName`
- Create a branch: `git branch branchName`
- Switch to a different branch: `git checkout branchName`
- Create and switch to a new branch: `git checkout -b branchName`
- Merge a chosen branch with the working (current) branch: `git merge branchName`

# Time travel

Reset to previous version (delete last commit and return one commit back): 
- `git reset --hard HEAD~1` or `git reset --hard f42d8d5` with a commit id
- `git push --force` or `git push origin HEAD --force`

Delete uncommited changes: `git clean -fxd`

Change the name of the last commit: `git commit --amend` -> `git push --force`

Add extra commit files to previous commit: `git commit --amend --no-edit`

# ???

Force git pull by removing all uncommitted changes (even if staged), and then pull:
```bash
### Remove the uncommitted changes from the staging area
git reset --hard HEAD
git pull

### Remove the untracked files from the Git directory
git stash drop
```
