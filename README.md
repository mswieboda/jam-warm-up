# Jam Warm Up

## Installation

## Windows

if compiling/installing from Windows, please first run:

```
win_shards_install.bat
```

to install shards and clone crsfml v2.5.3 and compile it for windows directly

then run:

```
win_shards_postinstall.bat
```

to copy the specific Window crsfml v2.5.3 compiled files to this `lib/crsfml`


## Mac or Linux

[install SFML](https://github.com/oprypin/crsfml#install-sfml)

```
shards install
```


### Linter

(won't work on Windows as we used `shards install --skip-postinstall` so it won't get the binary)

```
bin/ameba
```

or

```
bin/ameba --fix
bin/ameba --gen-config
```
etc, see [ameba](https://github.com/crystal-ameba/ameba)

## Compiling

### Dev / Test

```
make
```

or

```
make test
```

### Release

```
make release
```

### Packaging

#### Windows

creates Windows release build, packages and zips

```
make winpack
```

you'll need `7z` ([7zip](https://www.7-zip.org/) binary) installed ([download](https://www.7-zip.org/))

zips up SFML DLLs, assets, `run.bat` (basically the .exe) to `build/jam_warm_up-win.zip`

#### Mac

```
make macpack
```

creates Mac OSX release build, packages and zips

you'll need installed:
- `7zz` ([7zip](https://www.7-zip.org/) binary) via `brew install 7zip`
- `platypus` ([Platypus](https://sveinbjorn.org/platypus) binary) via `brew install --cask platypus` then in `Platypus > Preferences` install the command line tool

zips up SFML libs, ext libs, assets, `jam_warm_up.app` (created by [Platypus](https://sveinbjorn.org/platypus)) to `build/jam_warm_up-mac.zip`
