// THIS DOCUMENT DETERMINES FINAL PRINT STATEMENT

func pl(str: String, count: Int) -> String {
    if str == "directory" {
        return count != 1 ? "directories" : "directory"
    } else if str == "have" {
        return count != 1 ? "have" : "has"
    } else if str == "repository" {
        return count != 1 ? "repositories" : "repository"
    }
}

/* rCount -- number of repos; rDirs -- which repos */
/* nCount -- number of folders without repos; nDirs -- which repos */
func printResult(isQuiet: Bool, repos: [String], notRepos: [String]) {

    // EMPTY VARIABLES

    var printLine = ""

    // COUNTS

    let repoCount = repos.count
    let notRepoCount = notRepos.count
    let dirCount = repoCount + notRepoCount

    // HELPER STATEMENTS

    let reposLine = "\(repoCount) \(repoCount != 1 ? "repositories" : "repository") found:"
    let repos = "📁 \(repos.map { $0 }.joined(separator: "\n📁 "))"

    // SWITCH STATEMENT –– BASED ON isQuiet

    switch isQuiet {
    case (true || false) && dirCount == 0:
        printLine = "0 directories found. No repositories to check."
    case true:
        if repoCount == dirCount {
            printLine =
                "\(repoCount) of \(dirCount) \(pl(str: "repository", count: (repoCount)))) found."
        } else if repoCount == 0 && notRepoCount > 0 {
            printLine =
                "0 repositories found, but \(dirCount) \(dirCount != 1 ? "directories exist." : "directory exists.")"
        } else if repoCount > 0 && notRepoCount == 0 {
            printLine = "\(repoCount) \(repoCount != 1 ? "repositories" : "repository") found."
        } else if repoCount > 0 && notRepoCount > 0 {
            printLine =
                "\(repoCount) \(repoCount != 1 ? "repositories" : "repository") and \(notRepoCount) \(notRepoCount != 1 ? "directories" : "directory") without repositories found."
        }
    case false:
        if repoCount == dirCount {
            if repoCount == 1 {
                printLine = "1 directory found and it contains a repo: \(repos)"
            } else if repoCount > 1 {
                printLine =
                    ("""
                    \(dirCount) directories found and ALL contain a repo:
                    \(repos)
                    """)
            }
        } else if repoCount == 0 && notRepoCount > 0 {
            printLine =
                ("""
                \(dirCount) \(pl(str: "directory", count: dirCount)) found, and 0 have repos:
                \(notRepos)
                """)
        } else if repoCount > 0 && notRepoCount > 0 {
            printLine =
                ("""
                \(repoCount) of \(dirCount) \(pl(str: "directory", count: dirCount)) found \(pl(str: "have", count: (repoCount))) a repo:
                \(notRepos)
                """)
        }
    default: printLine = ""
    }

    let nprint =
        "The following \(nCount) \(nCount != 1 ? "directories contain" : "directory contains") no git repo:"
    let nDirs = "❌ \(rDirs.map { $0 }.joined(separator: "\n❌ "))"

    if isQuiet == true {
        statement =
            ("""
            \(qTruth)
            """)
    } else if rCount == 0 {
        statement =
            ("""
            \(nTruth)
            """)
    } else if rCount != 0 && nCount == 0 {
        statement =
            ("""
            \(rprint)
            \(rdirs)
            \(rTruth)
            """)
    } else if rCount == 0 && nCount != 0 {
        statement =
            ("""
            \(nprint)
            \(nDirs)
            \(nTruth)
            """)
    } else if rCount != 0 && nCount != 0 {
        statement =
            ("""
            \(rprint)
            \(rdirs)

            \(nprint)
            \(nDirs)
            """)
    }

    print(statement)
}
