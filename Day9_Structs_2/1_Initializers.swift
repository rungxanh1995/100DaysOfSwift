// 1. Initializers
// Are special methods that provide different ways to create the struct
// All structs got a default one, called "memberwise initializer". This asks for a value for each property when creating the struct
// Sample code from Paul Hudson
struct User {
	var username: String
}
// Normally when creating an object of the struct, we must provide the value of the struct’s properties
var user = User(username: "twostraws")

// However, can also provide our own initializer to replace the default init
struct User {
	var username: String
	// init is a func, but you don’t write "func" before init
	// and MAKE SURE all properties of the struct have a value before ending the init()
	init() {
		username = "Anonymous"
		print("Creating a new user!")
	}
}
// Now when creating the struct’s object, no need to feed the property upfront
var user = User()
// But can change the default value of the property anytime
user.username = "twostraws"

/////////////////////////////////////////////////////////////////
// Extra read: How memberwise initializers work?
// When defining a custom init(), the default (memberwise) init() gets overriden
// If still want to use it, in other words when creating a struct’s object, if you want to pass values to the struct’s properties, you must create an "extension" of the struct with the custom init() in there
struct Employee {
	var name: String
	var yearsWorked = 0
	// and the memberwise init() still works, and hidden
}
extension Employee {
	// custom init() code here
	init() {
		self.name = "Anonymous"
		print("Creating an anonymous employee…")
	}
}
// Creating a named employee now works
let joe = Employee(name: "Joe Pham")
// As does creating a default anonymous employee
let newEmployee = Employee()


/////////////////////////////////////////////////////////////////
// Extra examples from mini test questions & explanations
// 1.
struct Book {
	var title: String
	var author: String
	init(bookTitle: String) {
		title = bookTitle
	}
}
let book = Book(bookTitle: "Beowulf")
// this code seems valid, however init() got ended without establishing all default value of the struct’s properties, in this case the "author"

// 2.
struct Media {
	var type: String
	var users: Int
	init() {
		
	}
}
let tv = Media(type: "Television", users: 10_000_000)
// this code is invalid, even though there’s nothing in init()
// because this init() is still considered a custom one
// so you must return default values for all properties of the struct
// & put the init() in an extension if want to create the "tv" like that

// 3.
struct Experiment {
	var cost = 0
}
let lhc = Experiment(cost: 13_250_000_000)
// this code is valid with default memberwise init() intact

// 4.
struct Wine {
	var grape: String
	var region: String
}
let malbec = Wine(grapes: "Malbec", region: "Cahors")
// this code is invalid. Why???
// tho it seems like all properties were fed with values
// however, it all comes down to a typo with "grapes"

// 5.
struct Dictionary {
	var words = Set<String>()
}
let dictionary = Dictionary()
// this code is valid. But why didn’t I see any value passed into the property name?
// let’s start slowly
// Set is a "generic" type in Swift
// Meaning when declaring a set like that, we have to declare the dataType between <> to define the type of values the set will hold
// Now var words = Set<String>() is a initialization syntax of Set
// the () calls to the init func that creates the set
// in this particular case, () takes in no params
// so the init of Set defines an empty set of string
// therefore, let dictionary = Dictionary() doesn’t need value for the "words" property
// but if you need to pass in, can code like this
// let dictionary = Dictionary(words: Set(["word1", "word2"]))

// 6.
struct Sport {
	var name: String
	var isOlympicSport: Bool
}
let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: "false")
// this code is clearly invalid, as isOlympicSport was passed a string instead of a bool

// 7.
struct Country {
	var name: String
	var usesImperialMeasurements: Bool
	init(countryName: String) {
		name = countryName
		let imperialCountries = ["Liberia", "Myanmar", "USA"]
		if imperialCountries.contains(name) {
			usesImperialMeasurements = true
		} else {
			usesImperialMeasurements = false
		}
	}
}
// this code is super interesting, and it is valid

// 8.
struct Tree {
	var type: String
	var hasFruit: Bool
	func init() {
		type = "Cherry"
		hasFruit = true
	}
}
let cherryTree = Tree()
// this code is clearly invalid as init() shouldn’t have "func"

// 9.
struct Starship {
	var name: String
	var maxWarp: Double
	init(starshipName: String) {
		name = starshipName
	}
}
let voyager = Starship(starshipName: "Voyager")
// this code is invalid as maxWarp wasn’t set with a default value in init()

// 10.
struct Message {
	var from: String
	var to: String
	var content: String
	init() {
		from = "Unknown"
		to = "Unknown"
		content = "Yo"
	}
}
let message = Message()
// as boring as this code is, it’s still valid

// 11.
struct PowerTool {
	var name: String
	var cost: Int
}
let drill = PowerTool(name: "Hammer Drill", cost: 80)
// this code is valid, as default init() wasn’t tampered with
// and "drill" declared with both properties’ values passed in

// 12.
struct Cabinet {
	var height: Double
	var width: Double
	var area: Double
	init(itemHeight: Double, itemWidth: Double) {
		height = itemHeight
		width = itemWidth
		area = height * width
	}
}
let drawers = Cabinet(itemHeight: 1.4, itemWidth: 1.0)
// this code is valid because
// the init() says it accepts 2 properties (albeit with name changed)
// area is a computed property and wasn’t defined in init(), so it doesn’t need to be passed in with "drawers"
// in fact, passing in area like this would be invalid
// let drawers = Cabinet(itemHeight: 1.4, itemWidth: 1.0, area: 2)
// because 1, drawers is being a constant
// and 2. area wasn’t to be fed in as said by init()