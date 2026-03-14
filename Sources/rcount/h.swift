func pluralize(word: String, type: String, number: Int) -> String{
    var nw = word

    if type == "irregular/y" {
        if number != 1 {
            nw = word.dropLast() + "ies"
        } else {
            nw = word
        }
    }

    return nw
}