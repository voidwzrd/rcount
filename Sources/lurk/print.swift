import ArgumentParser
import Foundation



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
