import ArgumentParser
import Foundation

@main
struct rcount: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "rcount",
        abstract: "Shows how many local folders contain a git repo",
        version: "0.3"
    )

    @Flag(name: .shortAndLong, help: "Limit information to number of repos found.")
    var quiet = false

    func run() throws {

        let fm = FileManager.default
        let path = URL(fileURLWithPath: fm.currentDirectoryPath)

        var repos = [String]()
        var notRepos = [String]()

        let items = try fm.contentsOfDirectory(
            at: path,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles])

        for item in items {
            let values = try item.resourceValues(forKeys: [.isDirectoryKey])

            if values.isDirectory == true {
                if checkGitRepoStatus(dir: "\(item.lastPathComponent)") == true {
                    repos += [item.lastPathComponent]
                } else {
                    notRepos += [item.lastPathComponent]
                }
            }
        }

        printResult(isQuiet: quiet, repos: repos, notRepos: notRepos)
    }
}
