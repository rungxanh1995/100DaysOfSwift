// 4. Method in struct
// A func within a struct is called a "method" of that struct

// Paul Hudson sample code
struct City {
	var population: Int
	
	func collectTaxes() -> Int {
		return population * 1_000
	}
}
let london = City(population: 9_000_000)
london.collectTaxes()

///////////////////////////////////////////////////////////////
// Personal code & notes
// Difference with functions
// 1. Method is func that belongs to a type (struct, enum, class)
// 2. Struct method reduces namespace pollution, as method name is restricted within a struct unless specifically called; while a func once defined will get its name reserved across the entire program


// In the context of a 🇨🇦 city amid Covid-19
struct City {
	var population: Double
	// Declare unemployed as an estimated computed property
	var unemployed: Double { return population * 0.1}
	// Or can also code like this, with "return" omitted
	// var unemployed: Double { population * 0.1}
	
	// Define method
	func issueCERB() -> Double {
		unemployed * 2_000
	}
}
let toronto = City(population: 2_900_000)
print("Amount of CERB fund to be issued: \(toronto.issueCERB())")

// Output from console
// Amount of CERB fund to be issued: 580000000.0

// Some extra examples from mini reading test questions, with personal twists
// 1.
struct Student {
	var name: String
	var sleepy: Bool
	func study() {
		if sleepy {
			print("I’m too tired rn.")
		} else {
			print("I’m hitting the books!")
		}
	}
}

// 2.
struct Event {
	var ticketPrices = [100, 200, 500]
	func buyTickets(tier: Int) {
		let cost = ticketPrices[tier]
		print("That’d be $\(cost), please.")
	}
}

// 3.
struct Desk {
	var isAdjustable: Bool
	func adjust(to newHeight: Int) {
		if isAdjustable {
			print("Adjusting now to \(newHeight)...")
		} else {
			print("Either cut off your desk or find some bricks lol!")
		}
	}
}
let myDesk = Desk(isAdjustable: true)
myDesk.adjust(to: 1)

// 4.
struct Pokemon {
	var name: String
	func attack(with attackType: String) {
		print("\(name) uses \(attackType)!")
	}
}

// 5.
struct WaterBottle {
	var capacity: Int
	func refill() {
		print("Refilling up to \(capacity)ml.")
	}
}

// 6.
struct Venue {
	var name: String
	var maxCapacity: Int
	func makeBooking(for people: Int) {
		if people > maxCapacity {
			print("Sorry we can only accommodate \(maxCapacity).")
		} else {
			print("\(name) is booked and all yours!")
		}
	}
}

// 7.
struct User {
	var name: String
	var street: String
	var city: String
	var postalCode: String
	func printAddress() -> String {
		return """
		\(name)
		\(street)
		\(city)
		\(postalCode)
		"""
	}
}

// 8.
struct House {
	var isExpensiveArea = false
	var numberOfRooms: Int
	func estimatePrice() -> Int {
		if isExpensiveArea {
			return numberOfRooms * 100_000
		} else {
			return numberOfRooms * 50_000
		}
	}
}