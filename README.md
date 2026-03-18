# lurk
macOS Terminal app that counts repositories within a local directory

## Download and Install

1. Clone repo from Github
```
git@github.com:liminalwizard/lurk.git
cd lurk
```

2. Build the executable via Swift Package Manager
```
swift build -c release
```

4. Install Globally
```
sudo mv .build/release/lurk /usr/local/bin/lurk
```

5. Verify installation
```
which lurk
```