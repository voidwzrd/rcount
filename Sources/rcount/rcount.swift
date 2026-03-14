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
struct rcount {
    static func main() throws {
        let fileManager = FileManager.default
        let path = URL(fileURLWithPath: fileManager.currentDirectoryPath)

        var repoCount = 0

        let items = try fileManager.contentsOfDirectory(
            at: path,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles])

        for item in items {
            let values = try item.resourceValues(forKeys: [.isDirectoryKey])

            if values.isDirectory == true {
                checkForGitRepo(dir: "\(item.lastPathComponent)") == true ? repoCount += 1 : nil

                print("📁 \(item.lastPathComponent)")
            }
        }

        print("\(repoCount) \(pluralize(word: "repository", type: "irregular/y", number: repoCount)) found.")
    }
}
