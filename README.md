# rcount
CLI tool that shows how many local folders contain a git repo

## User Stories

1. Users should be able to run `rcount` from a local directory and get returned A) the number of directories within it that have a git repo and B) how many do not.
2. Users should be able to get a list of which repos do/don't have repos.

## Roadmap
- Implement option to `git init` select directories.

## Download and Install

1. Clone repo from Github
```git@github.com:voidwzrd/rcount.git
cd rcount```

2. Build the executable via Swift Package Manager
```swift build -c release```

3. Install Globally
```sudo mv .build/release/rcount /usr/local/bin/rcount```

4. Verify installation
```which rcount```
