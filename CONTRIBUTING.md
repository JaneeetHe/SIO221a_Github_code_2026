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
