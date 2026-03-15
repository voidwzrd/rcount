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

        let fileManager = FileManager.default
        let path = URL(fileURLWithPath: fileManager.currentDirectoryPath)

        var rCount = 0
        var nCount = 0
        var rDirs = [String]()
        var nDirs = [String]()

        let items = try fileManager.contentsOfDirectory(
            at: path,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles])

        for item in items {
            let values = try item.resourceValues(forKeys: [.isDirectoryKey])

            if values.isDirectory == true {
                if checkForGitRepo(dir: "\(item.lastPathComponent)") == true {
                    rCount += 1
                    rDirs += [item.lastPathComponent]
                } else {
                    nCount += 1
                    nDirs += [item.lastPathComponent]
                }
            }
        }

        printResult(
            rCount: rCount,
            nCount: nCount,
            rDirs: rDirs,
            nDirs: nDirs,
            isQuiet: quiet
        )
    }
}