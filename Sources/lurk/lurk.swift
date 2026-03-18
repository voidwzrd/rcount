import ArgumentParser
import Foundation

func printOutput(isQuiet: Bool, repos: [String], notRepos: [String]) {
    let repoCount = repos.count
    let notRepoCount = notRepos.count
    let directoryCount = repoCount + notRepoCount

    let repos = "📁 \(repos.map { $0 }.joined(separator: "\n📁 "))"
    let notRepos = "📁 \(notRepos.map { $0 }.joined(separator: "\n📁 "))"

    let zeroNotification = "0 directories found. No repositories to check."
    var outputMessage = ""

    /* ////////////////////////////// */

    switch isQuiet {
    case true:
        if directoryCount == 0 {
            outputMessage = zeroNotification
        } else {
            outputMessage =
                "\(repoCount) \(repoCount != 1 ? "repositories" : "repository") found."
        }
    case false:
        // 0 DIRECTORIES
        switch directoryCount {
        case 0:
            outputMessage = zeroNotification
        case 1:
            // IF ONLY 1 DIRECTORY AND IT'S A REPO
            if directoryCount == repoCount {
                outputMessage =
                    """
                    The only directory is a repo:
                    \(repos)
                    """
                // IF ONLY 1 DIRECTORY AND IT'S A REPO
            } else if directoryCount == notRepoCount {
                outputMessage =
                    """
                    The only directory is not a repo:
                    \(notRepos)
                    """
            }
        case let directoryCount
        where directoryCount > 1:
            // IF ALL > 1 DIRECTORIES ARE REPOS
            if (directoryCount == repoCount) && notRepoCount == 0 {
                outputMessage =
                    """
                    Every directory is a repo:
                    \(repos)
                    """
                // IF ALL > 1 DIRECTORIES ARE NOT REPOS
            } else if repoCount == 0 && (directoryCount == notRepoCount) {
                outputMessage =
                    """
                    No directory here is a repo:
                    \(notRepos)
                    """
            } else if repoCount > 1 && notRepoCount == 1 {
                outputMessage =
                    """
                    Most directories here are a repo:
                    \(repos)
                    ----------
                    1 directory here is not a repo:
                    \(notRepos)
                    """
            } else if repoCount > 1 && notRepoCount > 1 {
                outputMessage =
                    """
                    \(repoCount) directories are repos:
                    \(repos)
                    ----------
                    \(notRepoCount) directories are not repos:
                    \(notRepos)
                    """
            } else if repoCount == 1 && notRepoCount > 1 {
                outputMessage =
                    """
                    1 directory here is a repo:
                    \(repos)
                    ----------
                    Most directories here are not repos:
                    \(notRepos)
                    """
            }
        default: outputMessage = "Unknown case accounted for: print.swift line 99"
        }
    }

    print(outputMessage)
}

func runGit(args: [String]) -> Bool {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
    process.arguments = args

    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe

    do {
        try process.run()
        process.waitUntilExit()
    } catch {
        return false
    }

    return process.terminationStatus == 0
}

@main
struct Lurk: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "lurk",
        abstract: "macOS Terminal app that counts repositories within a local directory",
        version: "1.0"
    )

    @Flag(name: .shortAndLong, help: "Limit information to number of repos found.")
    var quiet = false

    @Flag(name: .shortAndLong, help: "This is coming, for now it doesn't work. :)")
    var verbose = false

    func validate() throws {
        if quiet && verbose {
            throw ValidationError("Cannot use --quiet and --verbose together.")
        }
    }

    func run() throws {
        let fm = FileManager.default
        let path = URL(fileURLWithPath: fm.currentDirectoryPath)
        let isPathRepo = runGit(args: ["rev-parse", "--is-inside-work-tree"])

        var repos = [String]()
        var notRepos = [String]()

        let items = try fm.contentsOfDirectory(
            at: path,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles])

        switch isPathRepo {
        case true:
            if quiet {
                print("This is a repo. Exiting.")
            } else {
                print("You are currently inside of a repo. No further checks will be made.")
            }
        case false:
            for item in items {
                let values = try item.resourceValues(forKeys: [.isDirectoryKey])
                let item = item.lastPathComponent

                if values.isDirectory == true {
                    if runGit(args: [
                        "-C", "\(item)", "rev-parse", "--is-inside-work-tree",
                    ]) {
                        repos += [item]
                    } else {
                        notRepos += [item]
                    }
                }
            }

            printOutput(isQuiet: quiet, repos: repos, notRepos: notRepos)
        }
    }
}