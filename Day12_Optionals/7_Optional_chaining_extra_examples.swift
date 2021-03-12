// 7. Optional chaining
// Code examples from mini test questions
// Question: these codes are valid in Swift - T/F?

// 1.
let names = ["Taylor", "Paul", "Adele"]
let lengthOfLast = names.last?.count?
// false, the code is not valid
// as Swift defines "count" as a regular property, not an optional
// should be lengthOfLast = names.last?.count

// 2.
let credentials = ["twostraws", "fr0sties"]
let lowercaseUsername = credentials.first.lowercased()
// false, this code is invalid
// Swift defines "first" as an optional, because it might not know if an array passed in has value or be nil
// should be credentials.first?.lowercased()

// 3.
let songs: [String]? = [String]()
let finalSong = songs?.last?.uppercased()
// true, the code is valid
// songs is explicitly defined as an optional Array? of string
// hence songs? is correct
// last is an optional property, hence last? is also correct

// 4.
func albumReleased(in year: Int) -> String? {
	switch year {
		case 2006: return "Taylor Swift"
		case 2008: return "Fearless"
		case 2010: return "Speak Now"
		case 2012: return "Red"
		case 2014: return "1989"
		case 2017: return "Reputation"
		default: return nil
	}
}
let album = albumReleased(in: 2006)?.uppercased()
// true, the code is valid
// func was defined to return an optional String?
// hence calling it w/ albumReleased(in: 2006)? is correct

// 5.
let attendees: [String] = [String]()
let firstInLine = attendees?.first?.uppercased()
// false, the code is invalid
// the array "attendees" is explicitly defined as a regular array
// hence attendees? is incorrect
// should be attendees.first?.uppercased()

// 6.
let shoppingList = ["eggs", "tomatoes", "grapes"]
let firstItem = shoppingList.first?.appending(" are on my shopping list")
// true, the code is valid
// shoppingList is being implicitly inferred as a regular array
// hence shoppingList (w/o "?") is correct

// 7.
let captains: [String]? = ["Archer", "Lorca", "Sisko"]?
let lengthOfBestCaptain = captains.last?.count
// false, the code is invalid w/ 2 errors
// the trailing "?" at the end of 1st line
// captains is defined as an optional string array, so captains. (w/ no "?") is incorrect

// 8.
func loadForecast(for dayNumber: Int) -> String {
	print("Forecast unavailable.")
	return nil
}
let forecast = loadForecast(for: 3)?.uppercased()
// false, this code is invalid
// the func was defined to return a regular string
// so "return nil" is incorrect
// so is loadForecast()?
// should be placing a "?" to make it String?

// 9.
let capitals = ["Scotland": "Edinburgh", "Wales": "Cardiff"]
let scottishCapital = capitals["Scotland"]?.uppercased()
// true, this code is valid, and places "EDINBURGH" as an optional string to scottishCapital

// 10.
let favoriteColors = ["Paul": "Red", "Charlotte": "Pink"]
let charlotteColor = favoriteColors["Charlotte"]?.lowercased()
// true, this code is valid, and places "pink" as an optional string to charlotteColor

// 11.
let opposites = ["hot": "cold", "near": "far"]
let oppositeOfLight = opposites["light"].uppercased()
// false, this code is invalid
// opposites["itemName"] in an array/dict returns an optional
// should be opposites["light"]?.uppercased()

// 12.
let racers = ["Hamilton", "Verstappen", "Vettel"]
let winnerWasVE = racers.first?.hasPrefix("Ve")
// true, the code is valid
// defining it as racers.first? means checking if the racers array has property "first" as an optional
