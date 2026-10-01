# Working with this repository

Learning git is part of this course, so we do homework the way working scientists
share code: **you fork the class repository, work in your own fork, and open a pull
request when you want to submit.**

Your work stays in your own GitHub account, this repository stays small, and you get
practice with the fork/branch/PR cycle that every collaborative code project uses.

---

## One time, at the start of the quarter

**1. Fork.** Go to https://github.com/malford11/SIO221a_Github_code_2026 and click **Fork**
(top right). You now have `https://github.com/YOUR-USERNAME/SIO221a_Github_code_2026`.

**2. Clone your fork** (note: *your* username, not mine):

```bash
git clone https://github.com/YOUR-USERNAME/SIO221a_Github_code_2026.git ~/SIO221a_Github_code_2026
cd ~/SIO221a_Github_code_2026
```

**3. Add the class repo as a second remote**, so you can pull in new lectures:

```bash
git remote add upstream https://github.com/malford11/SIO221a_Github_code_2026.git
git remote -v          # you should see 'origin' (yours) and 'upstream' (mine)
```

**4. Tell git who you are**, if you never have:

```bash
git config --global user.name  "Your Name"
git config --global user.email "you@ucsd.edu"
```

---

## Every week

**Get the new lectures** before you start:

```bash
git checkout main
git pull upstream main
git push origin main        # keep your fork's main in step with mine
```

**Make a branch for the assignment.** Branches are cheap; use one per problem set:

```bash
git checkout -b hw3
```

**Do the work.** Put it in `submissions/YOUR-NAME/` — e.g.
`submissions/jsmith/hw3.ipynb`. Keeping everyone in their own folder means two people
editing "hw3.ipynb" never collide.

**Commit as you go**, with messages that say what changed:

```bash
git add submissions/jsmith/hw3.ipynb
git commit -m "HW3: spectra of pier temperature, with confidence limits"
```

`git commit -m "stuff"` tells your future self nothing. Write the message for the
person who reads it in six months, who is probably you.

**Push and open a pull request:**

```bash
git push origin hw3
```

GitHub prints a link; follow it and click **Create pull request**. Set the base to
`malford11/SIO221a_Github_code_2026` `main` and the compare to your `hw3` branch. That PR is your
submission — I'll read it and comment there.

---

## Doing this from VS Code instead of the terminal

Everything above is just git, so you can drive it from VS Code's Source Control
panel (the branching icon in the left sidebar) instead of typing commands. The
one-time setup and every-week loop map over like this:

**Fork and clone.** Fork on the GitHub web page as above (VS Code can't do that
part — forking is a GitHub server-side operation, not a git command). Then:
`Cmd/Ctrl+Shift+P` → **Git: Clone** → paste your fork's URL
(`https://github.com/YOUR-USERNAME/SIO221a_Github_code_2026.git`) → pick where to
put it (use `~/SIO221a_Github_code_2026` so the notebooks' setup cell finds it) →
open the folder when VS Code asks.

**Add the upstream remote.** Source Control panel → **...** (More Actions) →
**Remote** → **Add Remote** → name it `upstream`, URL
`https://github.com/malford11/SIO221a_Github_code_2026.git`.

**Tell git who you are**, and do any other one-time setup, by opening a terminal
*inside* VS Code (Terminal menu → New Terminal) and running the same commands
listed above — VS Code's terminal is a real shell, nothing special about it.

**Get the new lectures:** click the branch name in the bottom-left status bar,
switch to `main`, then **...** → **Pull from...** → `upstream` → `main`. Then
**...** → **Push to...** → `origin` → `main` to update your fork.

**Make a branch:** click the branch name in the status bar → **Create new
branch...** → name it (e.g. `hw3`).

**Do the work**, same as always — edit the notebook in `submissions/YOUR-NAME/`.

**Commit:** the Source Control panel lists changed files. Hover a file and click
**+** to stage it (or **Stage All Changes**), type a real commit message in the
box above, and click the checkmark to commit.

**Push and open a pull request:** click **Sync Changes** (or **...** → **Push**).
The first time you push a new branch, VS Code offers to **Publish Branch** — say
yes, that's your `git push origin hw3`. If you have the "GitHub Pull Requests and
Issues" extension installed, VS Code will offer to open a PR for you right after;
otherwise follow the link GitHub gives you, same as the command-line flow — base
`malford11/SIO221a_Github_code_2026` `main`, compare your branch.

---

## Doing this from the GitHub web interface

You *can* fork, edit, and commit entirely in the browser — useful for a quick fix,
not for actual assignments, because **the web interface can't run your
notebook.** There's no Python or MATLAB kernel behind it, so anything that needs
execution still has to happen on your own machine.

What works in the browser: fork the repo (the **Fork** button), then either edit
a file directly on GitHub (open it in your fork, click the pencil icon) or press
`.` on any page in your fork to open `github.dev`, a full VS Code-like editor
running in the browser with its own Source Control panel — same stage/commit/push
steps as real VS Code above, no install required. Either way, when you commit you
can choose "Create a new branch for this commit and start a pull request," which
does the branch-and-PR step for you.

Use this for things like fixing a typo in your name or a markdown cell. For
problem sets, run the notebook locally, then push and open the PR from the
terminal or VS Code.

---

## Things worth knowing

**Don't commit data files.** The data you need is already in `data/`. If an
assignment has you download something new, leave it out of git — the `.gitignore`
already excludes the usual suspects. Repositories that accumulate data get slow and
unpleasant to clone, which is exactly what happened to the 2025 version of this repo.

**Notebooks make ugly diffs.** A notebook is a JSON file with your outputs embedded,
so git sees a huge change even when you edited one line. That's normal. If it bothers
you, look at [`nbdime`](https://nbdime.readthedocs.io/), which diffs notebooks
sensibly.

**Never `git push --force` on a shared branch.** It rewrites history for everyone
else. On your own fork's own branch it's merely rude to your own past self.

**If you get into a mess, don't panic and don't delete the folder.** Almost nothing
in git is truly lost. Bring it to office hours — untangling a real git mess is a
genuinely useful thing to watch someone do.

---

## Getting the setup working

The setup cell at the top of every notebook looks for this repository in a few
predictable places. If it can't find it, it stops and tells you so. The fix is either
to clone to `~/SIO221a_Github_code_2026`, or to set `SIO221A_ROOT` to wherever you actually put
it. See the [README](README.md) for the details.
