import ArgumentParser
import Foundation

// THIS DOCUMENT DETERMINES FINAL PRINT STATEMENT

<<<<<<< HEAD
func pl(count: Int, str: String) -> String {
    var returnable = ""

    if str == "be" {
        returnable = count != 1 ? "are" : "is"
    } else if str == "directory" {
        returnable = count != 1 ? "directories" : str
    } else if str == "have" {
        returnable = count != 1 ? "have" : "has"
    } else if str == "repository" {
        returnable = count != 1 ? "repositories" : str
=======
/* rCount -- number of repos; rDirs -- which repos */
/* nCount -- number of folders without repos; nDirs -- which repos */
func printResult(
    rCount: Int, nCount: Int, rDirs: [String], nDirs: [String], isQuiet: Bool, isVerbose: Bool
) {
    let rprint = "\(rCount) \(rCount != 1 ? "repositories" : "repository") found:"
    let rdirs = "📁 \(rDirs.map { $0 }.joined(separator: "\n📁 "))"

    let nprint =
        "The following \(nCount) \(nCount != 1 ? "directories contain" : "directory contains") no git repo:"
    let nDirs = "❌ \(rDirs.map { $0 }.joined(separator: "\n❌ "))"

    let rTruth = "ALL directories are repositories."
    let nTruth = "0 directories are repositories."
    let qTruth = "\(rCount) \(rCount != 1 ? "repositories" : "repository") found."

    var statement = ""

       

    if isQuiet == true {
        statement = qTruth
    } else if rCount == 0 {
        statement = nTruth
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
>>>>>>> e4890102325edecb5273b38e08ebd3298f3020ba
    }

    return returnable
}

func printMsg(isQuiet: Bool, repos: [String], notRepos: [String]) {

    // EMPTY VARIABLES

    var msg = ""

    // COUNTS

    let repoCount = repos.count
    let notRepoCount = notRepos.count
    let directoryCount = repoCount + notRepoCount

    let zeroDirStatus = "0 directories found. No repositories to check."

    // REPO LINES

    let repos = "📁 \(repos.map { $0 }.joined(separator: "\n📁 "))"
    let notRepos = "📁 \(notRepos.map { $0 }.joined(separator: "\n📁 "))"

    /* SWITCH STATEMENT */
    switch isQuiet {
    case true:
        if directoryCount == 0 {
            msg = zeroDirStatus
        } else {
            msg =
                "\(repoCount) \(repoCount != 1 ? "repositories" : "repository") found."
        }
    case false:
        // 0 DIRECTORIES
        switch directoryCount {
        case 0:
            msg = zeroDirStatus
        case 1:
            // IF ONLY 1 DIRECTORY AND IT'S A REPO
            if directoryCount == repoCount {
                msg =
                    """
                    The only directory is a repo:
                    \(repos)
                    """
                // IF ONLY 1 DIRECTORY AND IT'S A REPO
            } else if directoryCount == notRepoCount {
                msg =
                    """
                    The only directory is not a repo:
                    \(notRepos)
                    """
            }
        case let directoryCount
        where directoryCount > 1:
            // IF ALL > 1 DIRECTORIES ARE REPOS
            if (directoryCount == repoCount) && notRepoCount == 0 {
                msg =
                    """
                    Every directory is a repo:
                    \(repos)
                    """
                // IF ALL > 1 DIRECTORIES ARE NOT REPOS
            } else if repoCount == 0 && (directoryCount == notRepoCount) {
                msg =
                    """
                    No directory here is a repo:
                    \(notRepos)
                    """
            } else if repoCount > 1 && notRepoCount == 1 {
                msg =
                    """
                    Most directories here are a repo:
                    \(repos)
                    ----------
                    1 directory here is not a repo:
                    \(notRepos)
                    """
            } else if repoCount > 1 && notRepoCount > 1 {
                msg =
                    """
                    \(repoCount) directories are repos:
                    \(repos)
                    ----------
                    \(notRepoCount) directories are not repos:
                    \(notRepos)
                    """
            } else if repoCount == 1 && notRepoCount > 1 {
                msg =
                    """
                    1 directory here is a repo:
                    \(repos)
                    ----------
                    Most directories here are not repos:
                    \(notRepos)
                    """
            }

        // IF > 1 DIRECTORIES, == REPOS, 0 NOT REPOS
        // IF > 1 DIRECTORIES, 0 REPOS, == NOT REPOS
        // IF > 1 DIRECTORIES, 0 REPOS, > 1 NOT REPOS
        // IF > 1 DIRECTORIES, 1 REPOS, > 1 NOT REPOS
        // IF > 1 DIRECTORIES, > 1 REPOS, 1 NOT REPOS
        // IF > 1 DIRECTORIES, > 1 REPOS, > 1 NOT REPOS
        default: msg = "SOMETHING'S WRONG"
        }
    }
    /* END SWITCH STATEMENT /////////////////// */

    print(msg)
}
