# Section 5: Intro to K8s concepts

### This section is about familiarizing yourself with Kubernetes concepts. You'll follow along as Nigel Poulton explains very high level container and orchestration concepts. There's a very short demontration using his github psweb repo. That repo is located here:

`https://github.com/nigelpoulton/psweb`

### That said, a zip of the repo is located in this section 5 folder for your convenience. Just follow the instructions below to unzip and start using it. Please don't `git clone` Nigel's repo into your working folders, as they are already in a local git repo, themselves. Git does support submodules, but that's outside the purpose of this course.

#### Step 1: Ensure your local version of the repo is up to date with your forked origin/main
- use `git fetch` to discover any new changes in origin/main
- use `git pull` to make sure your local main matches origin/main

#### Step 2: Create a local branch from main
- use `git checkout -b section-5` to create and edit a new branch (you can name it whatever you like)
- note that working in a branch here and below is simply for practicing git

#### Step 3: Unzip the NodeExpressMongoDBDockerApp file
- `cd /<path>/learn-k8s-master/5-Intro_to_k8s_concepts` if not there already
- `unzip psweb.zip` (or your zip utility) to unzip the file

### Now you can open the folder in VS Code or IDE of choice and follow along with the video. For additional git practice, you can follow steps 4 - 7 in Section 1 README.md to commit changes to your main branch and clean up your working branch, if you made one.