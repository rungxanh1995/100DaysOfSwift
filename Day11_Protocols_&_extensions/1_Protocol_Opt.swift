// Previous but less versatile approach to a method with struct
struct Book {
  var name: String
}

func buy(_ book: Book) {
  print("I'm buying \(book.name).")
}

var book = Book(name: "Gone with the wind")
buy(book)
// this prints "I’m buying Gone with the wind."

/////////////////////////////////////////////////////////////////
// New method: Using protocols

// Now we create a more flexible, protocol-based approach
// Create the protocol Purchasable with intial properties/methods
// Set the permission for the property to get & set
protocol Purchasable {
	var name: String { get set }
}

// We can now define as many structs as needed
// With each adopting the protocol by being defined with ALL properties & methods from that protocol
struct Book: Purchasable {
	var name: String
	var author: String
}
struct Movie: Purchasable {
	var name: String
	var actors: [String]
}
struct Car: Purchasable {
	var name: String
	var manufacturer: String
}
struct Coffee: Purchasable {
	var name: String
	var strength: Int
}

// Defining the func is just same like before
func buyBook(_ book: Book) {
	print("I’m buying this book: \(book.name) from \(book.author).")
}
let myBook = Book(name: "The DaVinci Code", author: "Dan Brown")
buyBook(myBook)
// this prints "I’m buying this book: The DaVinci Code from Dan Brown."

// Better yet, we can define the func to accept any kind of a Purchasable item
func buyItem(_ item: Purchasable) {
	print("I’m buying a \(item.name).")
}
let myCoffee = Coffee(name: "Vietnamese instant coffee", strength: 10)
var myCar = Car(name: "Honda Civic", manufacturer: "Honda")
buyItem(myCoffee)
// this prints "I’m buying a Vietnamese instant coffee."
buyItem(myCar)
// this prints "I’m buying a Honda Civic."


// Another example with a protocol with a method
// And a class that conforms to the protocol
// Because there’s no example like this yet
protocol Swimmable {
	var waterBody: String { get set }
	func canSwim() -> String
}
class Water: Swimmable {
	var waterBody: String
	// because it’s a class, you MUST manually create its init()
	init(type name: String) {
		waterBody = name
	}
	func canSwim() -> String {
		if waterBody == "lake" {
			return "A \(waterBody) sounds too scary to swim in."
		} else {
			return "You can swim in the \(waterBody)."
		}
	}
}
let lakeOntario = Water(type: "lake")
lakeOntario.canSwim()
// this returns "A lake sounds too scary to swim in."
