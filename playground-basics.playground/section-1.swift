import UIKit

var str = "Hello, playground"

// Explicits & Inferred Values

let explicitVar : Int = 2
let inferredVar = 2

var colors = ["Blue", "Red", "Green"]

// Closures

let names  = ["Chris", "Bobby", "Jom", "Julio", "Wendy"]

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversed = sorted(names, backwards)

// Extensions

extension Int {
    func repetitions(task: () -> ()) {
        for i in 0..<self {
            task()
        }
    }
}

3.repetitions {
    println("Xio")
}
