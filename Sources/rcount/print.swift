// THIS DOCUMENT DETERMINES FINAL PRINT STATEMENT

func pl(str: String, count: Int) -> String {
    var returnable = ""

    if str == "be" {
        returnable = count != 1 ? "are" : "is"
    } else if str == "directory" {
        returnable = count != 1 ? "directories" : str
    } else if str == "have" {
        returnable = count != 1 ? "have" : "has"
    } else if str == "repository" {
        returnable = count != 1 ? "repositories" : str
    }

    return returnable
}

func printResult(isQuiet: Bool, repos: [String], notRepos: [String]) {

    // EMPTY VARIABLES

    var printLine = ""

    // COUNTS

    let repoCount = repos.count
    let notRepoCount = notRepos.count
    let dirCount = repoCount + notRepoCount

    // HELPER STATEMENTS

    let repos = "📁 \(repos.map { $0 }.joined(separator: "\n📁 "))"
    let notRepos = "📁 \(notRepos.map { $0 }.joined(separator: "\n📁 "))"

    // ALT SWITCH STATEMENT
    switch dirCount {
    case 0:
        printLine = "0 directories found. No repositories to check."
    case let dirCount
    where dirCount == repoCount:
        printLine =
            "\(pl(str: "all", count: (repoCount)))) \(dirCount) \(pl(str: "repository", count: (repoCount)))) found. Count: "
    default: printLine = ""
    }

    // SWITCH STATEMENT –– BASED ON isQuiet

    switch isQuiet {
    case (isQuiet == true || isQuiet == false) && dirCount == 0:
        printLine = "QUIET: 0 directories found. No repositories to check."
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
                \(repos)
                ---
                The remaining \(notRepoCount) \(pl(str: "directory", count: dirCount)) \(pl(str: "have", count: (repoCount))) no repo:
                \(notRepos)
                """)
        }
    }

    print(printLine)
}
