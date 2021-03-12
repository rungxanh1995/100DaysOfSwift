// 2. Unwrap optionals
// Extra code samples from mini test questions
// Question: These code will print a message - T/F?

// 1.
var favoriteMovie: String? = nil
favoriteMovie = "The Life of Brian"
if let movie = favoriteMovie {
	print("Your favorite movie is \(movie).")
} else {
	print("You don’t have a favorite movie.")
}
// true, this code prints "Your favorite movie is The Life of Brian."
// the 2nd line changed the var from nil to has content
// if let statement calls the var, unwraps it, sees that it has content, assigns it to var "movie", then the whole "let movie = favoriteMovie" statement is true because both of them have the same content, hence the 1st print statement printed

// 2.
var weatherForecast: String = "sunny"
if let forecast = weatherForecast {
	print("The forecast is \(forecast).")
} else {
 	print("No forecast available.")
 }
 // false, the code is invalid
 // it attempts to use "if let" to unwrap weatherForecast, which is not optional
 
// 3.
let song: String? = "Shake It Off"
if let unwrappedSong = song {
	print("The name has \(unwrappedSong.count) letters.")
}
// true, this code prints the string out

// 4.
let currentDestination: String? = nil
if let destination = currentDestination {
	print("We’re walking to \(destination).")
} else {
	print("We’re just wandering.")
}
// true, this code prints the 2nd string as the var value is nil

// 5.
let tableHeight: Double? = 100
if tableHeight > 85.0 {
	print("The table is too high.")
}
// false, this code is invalid
// it attempts to compare an unwrapped optional
// could’ve unwrapped with a "!"

// 6.
let menuItems: [String]? = ["Pizza", "Pasta"]
if let items = menuItems {
	print("There are \(menuItems.count) items to choose from.")
}
// false, this code is invalid
// because it wrote "menuItems" in print statement of "if let"
// must’ve been "items" instead

// 7.
var score: Int = nil
score = 556
if let playerScore = score {
	print("You scored \(playerScore) points.")
}
// false, this code is invalid
// it attempts to assign nil to a non-optional integer

// 8.
let album = "Red"
let albums = ["Reputation", "Red", "1989"]
if let position = albums.firstIndex(of: album) {
	print("Found \(album) at position \(position).")
}
// true, this code prints the string
// it boils down to how the if let statement works
// specifically, "let position = albums.firstIndex(of: album)" is valid
// which then if evaluates that condition as true
// hence the string printed

// 9.
let userAge: Int? = 38
if let age = userAge {
	print("You are \(age) years old.")
}
// true, the code is valid and prints the message

// 10.
let favoriteTennisPlayer: String? = "Andy Murray"
if let player {
	print("Let’s watch \(player)’s highlights video on YouTube.")
}
// false, this code is invalid
// if let needs to bind an optional to a new, unwrapped name
// should’ve been "if let player = favoriteTennisPlayer"

// 11.
var winner: String? = nil
winner = "Daley Thompson"
if let name = winner {
	print("And the winner is... \(name)!")
}
// true, this code is valid and prints the message

// 12.
var bestScore: Int? = nil
bestScore = 101
if bestScore > 100 {
	print("You got a high score!")
} else {
	print("Better luck next time.")
}
// false, this code is invalid
// because tho bestScore was given a value, not nil, it’s still an optional
// but the code attempts to perform comparison on an unwrapped optional
// hence it’s invalid
