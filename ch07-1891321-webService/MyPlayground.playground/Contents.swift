import UIKit

var str = "Hello, playground"

let names = ["tiger", "fox", "lion", "bear"]
let reversed0 = names.sorted(by: { (first:String, second:String) -> Bool in return first < second })
print(reversed0)

let reversed1 = names.sorted() {
    (first:String, second:String) -> Bool in
    return first < second
}
print(reversed1)

let reversed2 = names.sorted() {
    (first, second) -> Bool in
    return first < second
}
print(reversed2)

let reversed3 = names.sorted() {
    // (first, second) -> Bool in
    return $0 < $1
}
print(reversed3)
