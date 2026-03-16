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

func checkGitRepoStatus(_ dirPath: String, currentDirPath: String,) -> Bool {
    // var result = ""

// if r = r
    // if dirPath.count == 0 {
    //     result = runGit(args: ["rev-parse", "--is-inside-work-tree"]) == "true" ? "true" : "false"
    // } else {
    //     // result = runGit(args: ["-C", "\(dir)", "rev-parse", "--show-toplevel"]) == true ? true : false
    //     result = "false"
    // }

    // let result = runGit(args: ["-C", "\(dir)", "rev-parse", "--is-inside-work-tree"])
//   ÷÷

return true

    // return result.trimmingCharacters(in: .whitespacesAndNewlines) == "true" ? true : false
}
