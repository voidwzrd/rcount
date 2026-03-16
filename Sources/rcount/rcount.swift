import ArgumentParser
import Foundation

@main
struct rcount: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "rcount",
        abstract: "Shows how many local directories contain a git repo",
        version: "0.3"
    )

    @Flag(name: .shortAndLong, help: "Limit information to number of repos found.")
    var quiet = false

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

                if values.isDirectory == true {
                    if runGit(args: [
                        "-C", "\(item.lastPathComponent)", "rev-parse", "--is-inside-work-tree",
                    ]) {
                        repos += [item.lastPathComponent]
                    } else {
                        notRepos += [item.lastPathComponent]
                    }
                }
            }

            printMsg(isQuiet: quiet, repos: repos, notRepos: notRepos)
        }
    }
}