// 7. Properties & methods of arrays
// Full list of avail array properties & methods can be called via Xcode’s code completion options

// Sample code from Paul Hudson
// A simple array to get started
var toys = ["Woody"]

// Read number of items in the array with count property
print(toys.count)
// this equals to 1

// Add a new item using append() method
toys.append("Buzz")
// this equals to toys = ["Woody", "Buzz"]

// Locate any item inside the array using its firstIndex() method
toys.firstIndex(of: "Buzz")
// this returns 1 as arrays count from 0

// Sort the items of the array alphabetically
print(toys.sorted())
// this requals to toys = ["Buzz", "Woody"]

Use remove() method to remove an item
toys.remove(at: 0)
// this removes "Buzz" from toys

// Type "toys." to access full list of properties & methods for array

// Note: you should use .isEmpty property to check if a string is null, instead of using .count == 0
// Details on this can be found at: https://www.hackingwithswift.com/articles/181/why-using-isempty-is-faster-than-checking-count-0


/////////////////////////////////////////////////////////////////
// Extra codes from mini test questions, and explanations
// 1.
var fibonacci = [1, 1, 2, 3, 5, 8]
fibonacci.sorted() == [1, 2, 3, 5, 8]
// this equals to false, as the sorted array is missing a 1

// 2.
var usedNumbers = [Int]()
for i in 1...10 {
	usedNumbers.append(i)
}
usedNumbers.count > 5
// this equals to true, and the array now has 10 elements

// 3.
let movies = ["A New Hope", "Empire Strikes Back", "Return of the Jedi"]
movies.firstIndex(of: "A New Hope") == 4
// this equals to false, as firstIndex of it is at 0

// 4.
let heights = [1.0, 1.2, 1.15, 1.39]
heights.remove(at: 0)
heights.count == 3
// this code is invalid as array heights is constant

// 5.
let spaceships = ["Serenity", "Enterprise"]
spaceships.contains("Serenity")
// this is true, and yes you can use .contains method in an array struct

// 6.
let tens = [30, 20, 10]
tens.sorted() == [10, 20, 30]
// this is true, and those "let" makes array "tens" a constant one, its elements can get sorted. However…
tens.append(40)
// …this is invalid, as the size of constant "tens" can’t be changed

// 7.
var examScores = [100, 95, 92]
examScores.insert(98)
// this is invalid, as .insert() method requires an index at which to insert the content

// 8.
let composers = ["Mozart", "Bach", "Beethoven"]
composers.append("Chopin")
composers.count == 4
// this is invalid as "composers" was defined as a constant array, thus can’t append

// 9.
var results = [true, true, false, true]
results.remove(at: 2)
results.count == 3
// this equals to true
