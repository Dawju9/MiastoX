 root  srv1270647  /Development/repos/MiastoX  ❯ l
➜ l
Permissions Size User Date Modified Name
drwxr-xr-x     - root 12 Apr 04:48   .git
drwxr-xr-x     - root 10 Apr 20:24   .github
drwxr-xr-x     - root 12 Apr 04:44   .lune
drwxr-xr-x     - root 10 Apr 20:24   .vscode
drwxr-xr-x     - root 10 Apr 20:24   _layouts
drwxr-xr-x     - root 10 Apr 20:24   assets
drwxr-xr-x     - root 10 Apr 20:24   collections
drwxr-xr-x     - root 10 Apr 20:24   gh-assets
drwxr-xr-x     - root 10 Apr 20:24   Packages
drwxr-xr-x     - root 10 Apr 20:24   projects
drwxr-xr-x     - root 12 Apr 04:44   scripts
drwxr-xr-x     - root 12 Apr 04:44   src
drwxr-xr-x     - root 10 Apr 20:24   styles
drwxr-xr-x     - root 10 Apr 20:24   translations
.rw-r--r--   658 root 12 Apr 04:44   .darklua.json
.rw-r--r--   379 root 12 Apr 04:44   .editorconfig
.rw-r--r--    90 root 10 Apr 20:24   .gitignore
.rw-r--r--   335 root 12 Apr 04:57   .luaurc
.rw-r--r--   657 root 12 Apr 04:44   .pre-commit-config.yaml
.rw-r--r--  1.4k root 12 Apr 04:44   .welcome.conf
.rw-r--r--   183 root 10 Apr 20:24   404.html
.rw-r--r--   438 root 12 Apr 04:44   _config.yml
.rw-r--r--  1.2k root 12 Apr 04:44   about.md
.rw-r--r--   255 root 10 Apr 20:24   aftman.toml
.rw-r--r--  2.2k root 12 Apr 04:44   build.project.json
.rw-r--r--  1.1k root 12 Apr 04:48   CHANGELOG.md
.rw-r--r--   595 root 12 Apr 04:44   config.toml
.rw-r--r--  2.4k root 12 Apr 04:44   default.project.json
.rw-r--r--  2.0k root 12 Apr 04:44   dev.project.json
.rw-r--r--  1.9k root 10 Apr 20:24   Game.rbxl
.rw-r--r--   348 root 12 Apr 04:44   Gemfile
.rw-r--r--  8.4k root 12 Apr 04:44   index.html
.rw-r--r--  1.4k root 10 Apr 20:24   jobs.html
.rw-r--r--   370 root 10 Apr 20:24   LICENSE
.rw-r--r--   16M root 10 Apr 20:24   lune.exe
.rw-r--r--  386k root 12 Apr 04:44   MiastoX-Final.rbxl
.rw-r--r--  373k root 12 Apr 04:44   MiastoX-Rojo.rbxl
.rw-r--r--  1.7k root 12 Apr 04:44   package.json
.rw-r--r--   793 root 10 Apr 20:24   projects.html
.rw-r--r--   932 root 10 Apr 20:24   README.md
.rw-r--r--   220 root 12 Apr 04:44   selene.toml
.rw-r--r--  2.7k root 10 Apr 20:24   sourcemap.json
.rw-r--r--   217 root 10 Apr 20:24   stylua.toml
.rw-r--r--  1.2k root 10 Apr 20:24   test.project.json
.rw-r--r--   447 root 12 Apr 04:58   wally.toml
 root  srv1270647  /Development/repos/MiastoX  ❯ cat CHANGELOG.md
➜ cat CHANGELOG.md
   1 # Changelog
   2
   3 The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
   4 and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
   5
   6 ## [v1.0.0] - 2026-04-12
   7
   8 ### Added
   9 - Integration with CityX framework via Wally package system
  10 - CI/CD workflow with GitHub Actions (lint, build, security scan)
  11 - Lune build scripts for alternative build system
  12 - Multiple build configurations (default, dev, test)
  13 - Config files: selene.toml, stylua.toml, .editorconfig, .pre-commit-config.yaml, .darklua.json
  14 - GitHub Pages with Jekyll configuration (Gemfile, _config.yml)
  15 - Game systems integration: PauseMenu, HUD, Shop, DataStore
  16 - Build outputs: MiastoX-Final.rbxl, MiastoX-Rojo.rbxl
  17 - Development scripts: dev.sh, release.sh, setup.sh
  18
  19 ### Changed
  20 - Updated client/server initialization to use CityX modules
  21 - Enhanced project structure for modularity
  22 - Updated documentation (index.html, about.md)
  23
  24 ### Removed
  25 - Deprecated src/shared/Hello.luau
  26
  27 ## [Unreleased]
  28
  29 ### Planned
  30 - Player statistics tracking
  31 - Leaderboard integration
  32 - Weather system
  33 - Power-up system
  34 - PvP zones
 root  srv1270647  /Development/repos/MiastoX  ❯ git
➜ git
usage: git [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           [--config-env=<name>=<envvar>] <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone     Clone a repository into a new directory
   init      Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add       Add file contents to the index
   mv        Move or rename a file, a directory, or a symlink
   restore   Restore working tree files
   rm        Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect    Use binary search to find the commit that introduced a bug
   diff      Show changes between commits, commit and working tree, etc
   grep      Print lines matching a pattern
   log       Show commit logs
   show      Show various types of objects
   status    Show the working tree status

grow, mark and tweak your common history
   branch    List, create, or delete branches
   commit    Record changes to the repository
   merge     Join two or more development histories together
   rebase    Reapply commits on top of another base tip
   reset     Reset current HEAD to the specified state
   switch    Switch branches
   tag       Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch     Download objects and refs from another repository
   pull      Fetch from and integrate with another repository or a local branch
   push      Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
See 'git help git' for an overview of the system.
 root  srv1270647  /Development/repos/MiastoX  ❯ git commit
➜ git commit
On branch master
Your branch is ahead of 'origin/master' by 3 commits.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   wally.toml

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        .luaurc

no changes added to commit (use "git add" and/or "git commit -a")
 root  srv1270647  /Development/repos/MiastoX  ❯ git add
➜ git add
Nothing specified, nothing added.
hint: Maybe you wanted to say 'git add .'?
hint: Turn this message off by running
hint: "git config advice.addEmptyPathspec false"
 root  srv1270647  /Development/repos/MiastoX  ❯ git add .
➜ git add .
 root  srv1270647  /Development/repos/MiastoX  ❯ git push
➜ git push
Username for 'https://github.com': ^C
⌛ 3171ms
 root  srv1270647  /Development/repos/MiastoX  ❯ g
GET                     getty                   groupdel
GID                     gh-assets/              groupmems
GITHUB_TOKEN            gh-help                 groupmod
GITHUB_USER             gh-log                  groups
g                       gh-push                 growpart
g++                     gh-show                 grpck
g++-13                  gh-status               grpconv
g3topbm                 gh-update               grpunconv
galiases                gh-welcome              grub-bios-setup
gapplication            ghostscript             grub-editenv
gawk                    giftopnm                grub-file
gawkbug                 ginstall-info           grub-fstest
gcc                     gio                     grub-glue-efi
gcc-13                  gio-querymodules        grub-install
gcc-ar                  git                     grub-kbdcomp
gcc-ar-13               git-receive-pack        grub-macbless
gcc-nm                  git-shell               grub-menulst2cfg
gcc-nm-13               git-upload-archive      grub-mkconfig
gcc-ranlib              git-upload-pack         grub-mkdevicemap
gcc-ranlib-13           glib-compile-schemas    grub-mkfont
gcov                    glog                    grub-mkimage
gcov-13                 gmake                   grub-mklayout
gcov-dump               gold                    grub-mknetdir
gcov-dump-13            gouldtoppm              grub-mkpasswd-pbkdf2
gcov-tool               gp-archive              grub-mkrelpath
gcov-tool-13            gp-collect-app          grub-mkrescue
gdbus                   gp-display-html         grub-mkstandalone
gdisk                   gp-display-src          grub-mount
gdk-pixbuf-csource      gp-display-text         grub-ntldr-img
gdk-pixbuf-pixdata      gpasswd                 grub-probe
gdk-pixbuf-thumbnailer  gpg                     grub-reboot
gem                     gpg-agent               grub-render-label
gem3.2                  gpg-connect-agent       grub-script-check
gemtopbm                gpg-wks-client          grub-set-default
gemtopnm                gpgconf                 grub-syslinux2cfg
gencat                  gpgparsemail            gs
genl                    gpgsm                   gsbj
geqn                    gpgsplit                gsdj
getcap                  gpgtar                  gsdj500
getconf                 gpgv                    gsettings
getent                  gpic                    gslj
gethostlatency-bpfcc    gprof                   gslp
gethostlatency.bt       gprofng                 gsnd
getkeycodes             grep                    gst
getln                   gresource               gtbl
getopt                  groff                   gunzip
getopts                 grog                    gzexe
getpcaps                grops                   gzip
gettext                 grotty
gettext.sh              groupadd
 root  srv1270647  /Development/repos/MiastoX  ❯ gh-update
➜ gh-update
/Development/scripts/version_manager.sh: line 87: PROJECTS: bad array subscript
❌ Nieznany komponent:
📋 Dostępne: framework, game, web
 root  srv1270647  /Development/repos/MiastoX  ❯ gh-help
➜ gh-help
===========================================================
📖 VERSION MANAGER - POMOC
===========================================================

Użycie:
  ./version_manager.sh <komenda> [argumenty]

===========================================================
📋 KOMENDY:
===========================================================

1️⃣  show
    - Pokaż wszystkie wersje projektów
    Przykład: ./version_manager.sh show

2️⃣  update <co> [typ]
    - Zwiększ wersję komponentu
    Typy: major (1.0.0→2.0.0), minor (1.0.0→1.1.0), patch (1.0.0→1.0.1)
    Przykład: ./version_manager.sh update framework patch

3️⃣  push <co> [msg]
    - Commit i push do GitHub
    Przykład: ./version_manager.sh push game "Poprawki bugów"

4️⃣  clone <co>
    - Clone repozytorium (informacja)
    Przykład: ./version_manager.sh clone web

5️⃣  status <co>
    - Sprawdź status git
    Przykład: ./version_manager.sh status framework

6️⃣  log <co>
    - Pokaż historię commitów
    Przykład: ./version_manager.sh log game

===========================================================
📦 PROJEKTY:
===========================================================

📌 framework  - CityX Framework (github.com/Dawju9/cityx)
📌 game      - MiastoX Game       (github.com/Dawju9/MiastoX)
📌 web       - MiastoX Web      (github.com/Dawju9/MiastoX/tree/web)

===========================================================
🔐 GITHUB:
===========================================================

Użytkownik: Dawju9
Token: ghp_f...Olg (ukończony)

===========================================================
📝 PRZYKŁADY:
===========================================================

# 1. Zobacz wersje
./version_manager.sh show

# 2. Zwiększ patch
./version_manager.sh update game patch

# 3. Commit i push
./version_manager.sh push framework "Update v1.0.1"

# 4. Sprawdź status
./version_manager.sh status game

# 5. Zobacz historię
./version_manager.sh log web

===========================================================

📦 WERSJE PROJEKTÓW
==================================================

🔹 web
   📌 Wersja: v1.0.0
   📅 Data: 2026-04-12
   📝 Opis: MiastoX Web
   📂 Repo: github.com/Dawju9/MiastoX/tree/web
   📁 Katalog: /Development/cityx/scripts/web

🔹 framework
   📌 Wersja: v1.0.0
   📅 Data: 2026-04-12
   📝 Opis: CityX Framework
   📂 Repo: github.com/Dawju9/cityx/tree/master
   📁 Katalog: /Development/cityx

🔹 game
   📌 Wersja: v1.0.0
   📅 Data: 2026-04-12
   📝 Opis: MiastoX Game
   📂 Repo: github.com/Dawju9/MiastoX/tree/main
   📁 Katalog: /Development/cityx

==================================================
📅 Ostatnia aktualizacja: 2026-05-12 07:42:54
 root  srv1270647  /Development/repos/MiastoX  ❯ gh-push
➜ gh-push
/Development/scripts/version_manager.sh: line 71: PROJECTS: bad array subscript
/Development/scripts/version_manager.sh: line 176: PROJECTS: bad array subscript
❌ Nieznany komponent:
 root  srv1270647 

