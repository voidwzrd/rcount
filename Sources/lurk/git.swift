import Foundation

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

func checkGitRepoStatus(dir: String) -> Bool {
    let result = runGit(args: ["-C", "\(dir)", "rev-parse", "--is-inside-work-tree"])
    return result
}
