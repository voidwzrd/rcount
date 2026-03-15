// THIS DOCUMENT DETERMINES FINAL PRINT STATEMENT

/* rCount -- number of repos; rDirs -- which repos */
/* nCount -- number of folders without repos; nDirs -- which repos */
func printResult( rCount: Int, nCount: Int, rDirs: [String], nDirs: [String], isQuiet: Bool) {
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
