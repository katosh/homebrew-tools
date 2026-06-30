# Homebrew Tap for katosh tools

## Install

```bash
brew tap katosh/tools
brew install <formula>
```

## Formulae

| Formula | Description |
|---------|-------------|
| [agent-sandbox](Formula/agent-sandbox.rb) | Kernel-enforced filesystem isolation for AI coding agents on Linux |
| [labsh](Formula/labsh.rb) | Project-local JupyterLab management CLI for humans and AI agents |

## Installing on older hosts (glibc < 2.39)

On a Linux host whose system glibc is older than Homebrew's current CI baseline
(`2.39` — e.g. EOL Ubuntu 18.04, glibc 2.27), Homebrew injects an **implicit**
`gcc` + `glibc` dependency into *every* formula it installs, whether or not the
formula needs a compiler. You can see it with `brew deps --annotate <formula>`
(the deps are tagged `[implicit]`). These injected packages frequently have no
pourable bottle for the old host, so Homebrew falls back to **building `gcc`
from source** — a build that can fail outright on such a host.

This is Homebrew host policy, **not** a dependency these formulae declare.
`agent-sandbox` is pure POSIX shell, and its only binary — the bundled `pasta`
network helper — is **statically linked** (`ldd` reports "not a dynamic
executable"; it pulls in zero `libgcc_s`/`libstdc++`/`GLIBCXX` symbols).
Nothing here links the GCC runtime, and the implicit `gcc`/`glibc` cannot be
removed from the formula side.

If you hit a failing `gcc` build on an old host, install without the implicit
dependencies — safe here precisely because nothing actually links them:

```bash
brew install --ignore-dependencies agent-sandbox      # or: agent-sandbox-rc
agent-sandbox --version                               # confirm it works
```

(On a current host with glibc ≥ 2.39, no implicit deps are injected and a plain
`brew install agent-sandbox` works as usual.)
