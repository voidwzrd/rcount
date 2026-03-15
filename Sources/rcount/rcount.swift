import ArgumentParser
import Foundation

func runGit(args: [String]) -> String {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
    process.arguments = args

    let pipe = Pipe()
    process.standardOutput = pipe
    process.standardError = pipe

    try! process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()

    return String(data: data, encoding: .utf8) ?? ""
}

func checkForGitRepo(dir: String) -> Bool {
    let result = runGit(args: ["-C", "\(dir)", "rev-parse", "--is-inside-work-tree"])
    return result.trimmingCharacters(in: .whitespacesAndNewlines) == "true" ? true : false
}

@main
struct rcount: ParsableCommand {
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