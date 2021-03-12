// 6. Properties & methods of String
// In Swift, strings are structs packed with functionality
// In fact almost all of Swift’s core types are implemented as structs (strings, ints, arrays, dicts, even bools)



// Create a test string
let string = "Do or do not, there is no try."

// Read the number of chars using count property
print(string.count)
// Output: 30

// Use hasPrefix() method that returns Bool value of string starts with specific letters
print(string.hasPrefix("Do"))
// Output: true

// Uppercase a string by calling uppercased() method
print(string.uppercased())
// Output: DO OR DO NOT, THERE IS NO TRY

// Have Swift break down the string letters into an Array
print(string.sorted())
// Output: [" ", " ", " ", " ", " ", " ", " ", ",", ".", "D", "d", "e", "e", "h", "i", "n", "n", "o", "o", "o", "o", "o", "r", "r", "r", "s", "t", "t", "t", "y"]


//////////////////////////////////////////////////////////////////
// Some extra examples
// 1.
let song = "Shake it Off"
song.uppercased().contains("SHAKE")
// this equals to "true"
// it first uppercased the string letters, then check if the content has "SHAKE" in it

// 2.
var favoriteIceCream = "choc chip"
favoriteIceCream.count > 10
// this equals to "false"

// 3.
var singer = "Taylor Swift"
singer.hasPrefix("TAY")
// this equals to "false"

// 4.
let username = "twostraws"
username.uppercased() == "TWOSTRAWS"
// this equals to "true"

// 5.
var str = ""
for i in 1...5 {
	str += "\(i)"
}
str.count == 5
// this equals to "true"
