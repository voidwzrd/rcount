# lurk
macOS Terminal app that counts repositories within a local directory

## Table of Contents
- [About](#about)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)

---

## About
Built with Swift 5 and ArgumentParser. Formerly known as `rcount`. Project is currently at version 1.0.

---

## Features
- Get number of repositories/plain directories within a local directory
- Supports quiet mode
- Automatically ignores nested repositories

---

## Installation

To install using bash, run
```
git@github.com:liminalwizard/lurk.git
cd lurk
swift build -c release
```

To install globally, run
```
sudo mv .build/release/lurk /usr/local/bin/lurk
```

To verify installation, run `which lurk`.

## Usage

- Run within a local directory with `lurk` to get number of directories with/without git repositories.
- `lurk --quiet` prints out only repositories found (`4 repositories found`).
