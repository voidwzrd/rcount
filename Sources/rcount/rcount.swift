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









        

        let isCurrentPathRepo = {
            do {
                try runGit(args: ["rev-parse", "--is-inside-work-tree"])

            }
        }


        print(type(of: runGit(args: ["rev-parse", "--is-inside-work-tree"])))
        print(runGit(args: ["rev-parse", "--is-inside-work-tree"]))
        print(isCurrentPathRepo)

        var repos = [String]()
        var notRepos = [String]()

        let items = try fm.contentsOfDirectory(
            at: path,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles])

        





        // switch items.count {
        //     case 0:

        //     case 1: 
        // }

        for item in items {
            let values = try item.resourceValues(forKeys: [.isDirectoryKey])
            let currentDir = item.deletingLastPathComponent()


            // let isCurrentPathRepo = 

            // if runGit(args: ["rev-parse", "--is-inside-work-tree"]) == "true" ? "true" : "false" {

            // } else if values.isDirectory == true {
            //     if checkGitRepoStatus(currentDir: currentDir.lastPathComponent, dir: "\(item.lastPathComponent)") == true
            //     {
            //         repos += [item.lastPathComponent]
            //     } else {
            //         notRepos += [item.lastPathComponent]
            //     }
            // }
        }

        if isCurrentPathRepo == "true" {
            print("You are currently inside of a repo.")
        }

    }
}
