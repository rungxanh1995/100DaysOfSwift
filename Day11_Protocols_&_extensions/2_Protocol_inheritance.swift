// 2. Protocol inheritance
// Sample code from Paul Hudson
// Personal notes also start from here

// Protocol inheritance is a protocol inheriting from another (or others)
// Meaning you CAN inherit from multiple protocols at the same time
// And can add your own customizations on top

// We start off by defining 3 separate protocols
protocol Payable {
	func calculateWages() -> Int
}
protocol NeedsTraining {
	func study(needsTraining: Bool)
}
protocol HasVacation {
	func takeVacation(days: Int)
}
// Note that these protocols only declare the NAMEs of these methods
// and whether the methods take in params or return something

// Now we create a single protocol that inherits from the other 3
protocol Employee: Payable, NeedsTraining, HasVacation {
	var name: String { get set }
}
// even can leave this protocol blank with just open & close braces
// if you’re not adding anything else into Employee

// Personal code here
// Now I can define for example a class FO from protocol Employee
class FO: Employee {
	var name: String
	// because it’s a class, need to define its init()
	init(name: String) {
		self.name = name
	}
	// now I MUST define ALL the methods from protocols that Employee has inherited from
	func calculateWages() -> Int {
		return 1_000
	}
	func study(needsTraining: Bool) {
		if needsTraining {
			print("Sending to study for re-training!")
		} else {
			print("No need to study for re-training!")
		}
	}
	func takeVacation(days: Int) {
		print("\(name) has already taken \(days) off.")
	}
}
// Create an instance of class FO
let LamFO = FO(name: "Lam")
LamFO.calculateWages()
// this returns 1000
LamFO.study(needsTraining: true)
// this prints "No need to study for re-training!"
LamFO.takeVacations(days: 6)
// this prints "Lam has already taken 6 days off."

////////////////////////////////////////////////////////////////
// Another example from Paul Hudson about protocol inheritance piece by piece like Lego bricks

protocol Product {
	var price: Double { get set }
	var weight: Int { get set }
}
protocol Computer: Product {
	var cpu: String { get set }
	var memory: Int { get set }
	var storage: Int { get set }
}
protocol Laptop: Computer {
	var screenSize: Int { get set }
}
// now Laptop is the child protocol of Computer, which is also a child of Product

// Make use of the protocol by building data from it
struct MacBook: Laptop {
	// MUST define all inherited properties/methods from the inherit protocol
  var price: Double
  var weight: Int
  var cpu: String
  var memory: Int
  var storage: Int
  var screenSize: Int
}
let MacBookPro = MacBook(price: 1799, weight: 1500, cpu: "Apple M1", memory: 16, storage: 512, screenSize: 13)
