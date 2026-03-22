About r-base-feedstock
======================

Feedstock license: [BSD-3-Clause](https://github.com/conda-forge/r-base-feedstock/blob/main/LICENSE.txt)

Home: http://www.r-project.org/

Package license: GPL-2.0-or-later

Summary: R is a free software environment for statistical computing and graphics.

About this fork (`isolated` branch)
------------------------------------

This is a fork of the [conda-forge r-base feedstock](https://github.com/conda-forge/r-base-feedstock),
maintained on the `isolated` branch. It differs from the upstream package in one key way:

**R is isolated from the user's system-installed R packages.**

By default, R adds `~/R/<platform>-library/<version>` to `.libPaths()` on startup,
meaning packages installed outside conda can silently bleed into conda environments
and break reproducibility. This build disables that behaviour:

- `R_LIBS_USER` is unset when the conda environment is activated (restored on deactivation).
- The default `R_LIBS_USER` setting is commented out in `etc/Renviron` at build time
  (patch `0019-Disable-default-user-libraries.patch`).

After activation, `length(.libPaths())` is always 1 — only the conda environment's
own library is visible to R.

The recipe is in [rattler-build](https://prefix-dev.github.io/rattler-build/) format
(`recipe/recipe.yaml`) and is kept in sync with upstream via an automated weekly workflow.
If you need the standard (non-isolated) behaviour, use the
[conda-forge package](https://anaconda.org/conda-forge/r-base) instead.

Current build status
--------------------

[![Build (PR check)](https://github.com/roaldarbol/r-base-feedstock/actions/workflows/build.yml/badge.svg?branch=isolated)](https://github.com/roaldarbol/r-base-feedstock/actions/workflows/build.yml)
[![Build and upload](https://github.com/roaldarbol/r-base-feedstock/actions/workflows/build-and-upload.yml/badge.svg?branch=isolated)](https://github.com/roaldarbol/r-base-feedstock/actions/workflows/build-and-upload.yml)

Current release info
--------------------

| Name | Version | Channel |
| --- | --- | --- |
| r-base | [![prefix.dev version](https://img.shields.io/conda/vn/conda-forge/r-base.svg?label=isolated-r)](https://prefix.dev/channels/isolated-r) | [isolated-r on prefix.dev](https://prefix.dev/channels/isolated-r) |

Installing r-base
-----------------

This package is published to the `isolated-r` channel on [prefix.dev](https://prefix.dev/channels/isolated-r).

With **conda** or **mamba**, add the channel and install:

```
conda config --add channels https://prefix.dev/isolated-r
conda config --add channels conda-forge
conda config --set channel_priority strict
conda install r-base
```

With **pixi**, add the channel to your `pixi.toml`:

```toml
[project]
channels = ["https://prefix.dev/isolated-r", "conda-forge"]

[dependencies]
r-base = "*"
```

Or specify it per-package on the command line:

```
pixi add --channel https://prefix.dev/isolated-r r-base
```

Updating this feedstock
-----------------------

The `isolated` branch is kept up to date with upstream `conda-forge/r-base-feedstock`
via a weekly automated sync workflow. When upstream changes are detected in `recipe/`:

- If the rebase is clean, a PR is opened automatically for review.
- If there are conflicts (most likely when a new upstream patch touches the same files
  as our isolation changes), an issue is opened with manual resolution instructions.

To update the R version or make other recipe changes, open a PR targeting the `isolated`
branch. The build workflow will verify all platforms before merge.

Maintainers
-----------

- [@roaldarbol](https://github.com/roaldarbol/)

Upstream feedstock maintainers: [@conda-forge/r](https://github.com/orgs/conda-forge/teams/r/),
[@isuruf](https://github.com/isuruf/), [@mbargull](https://github.com/mbargull/),
[@mingwandroid](https://github.com/mingwandroid/), [@ocefpaf](https://github.com/ocefpaf/),
[@sodre](https://github.com/sodre/), [@xhochy](https://github.com/xhochy/)
