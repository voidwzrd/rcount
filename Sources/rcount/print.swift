// THIS DOCUMENT DETERMINES FINAL PRINT STATEMENT

/* rcount -- number of repos */
/* ncount -- number of folders without repos */
func printResult(rcount: Int, ncount: Int, rdirs: [String], ndirs: [String]) {
    let rprint = "\(rcount) \(rcount != 1 ? "repositories" : "repository") found:"
    let rdirs = "📁 \(rdirs.map { $0 }.joined(separator: "\n📁 "))"

    let nprint =
        "The following \(ncount) \(ncount != 1 ? "directories contain" : "directory contains") no git repo:"
    let ndirs = "❌ \(ndirs.map { $0 }.joined(separator: "\n❌ "))"

    let rtruth = "ALL directories are repositories."
    let ntruth = "0 directories are repositories."

    var statement = ""

    /* if there are no repos found, say 0 repos found + the following have no repos */
    if rcount == 0 {
        statement =
            ("""
            \(ntruth)
            """)
    } else if rcount != 0 && ncount == 0 {
        statement =
            ("""
            \(rprint)
            \(rdirs)
            \(rtruth)
            """)
    } else if rcount == 0 && ncount != 0 {
        statement =
            ("""
            \(nprint)
            \(ndirs)
            \(ntruth)
            """)
    } else if rcount != 0 && ncount != 0 {
        statement =
            ("""
            \(rprint)
            \(rdirs)

            \(nprint)
            \(ndirs)
            """)
    }

    print(statement)
}
