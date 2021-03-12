// 7. Mutability
// Extra code examples from mini test questions & explanations
// question: are these code valid in Swift?

// 1.
class Pizza {
	private var toppings = [String]()
	func add(topping: String) {
		toppings.append(topping)
	}
}
var pizza = Pizza()
pizza.add(topping: "Mushrooms")
// this code is valid
// tho toppings is private & can’t be access directly outside of the class, you can still use the methods of that class

// 2.
class School {
	 let students = 200
	 func expel(student: String, for reason: String) {
	 	print("\(student) has been expelled for \(reason).")
	 	students -= 1
	 }
}
let school = School()
school.expel(student: "Jason", for: "coding during class")
// this code is invalid
// because property "students" was defined as a constant
// to modify it, it must be a variable property

// 3.
class SewingMachine {
	var itemsMade = 0
	mutating func makeBag(count: Int) {
		itemsMade += count
	}
}
var machine = SewingMachine()
machine.makeBag(count: 1)
// this code is invalid
// there’s no "mutating func" in Swift classes

// 4.
struct Park {
	var numberOfFlowers = 1000
	func plantFlowers() {
		numberOfFlowers += 50
	}
}
let park = Park()
park.plantFlowers()
// this code is invalid
// because this is a struct
// to modify numberOfFlowers, the func must be "mutating"

// 5.
struct Piano {
	var untunedKeys = 3
	func tune() {
		if untunedKeys > 0 {
			untunedKeys -= 1
		}
	}
}
var piano = Piano()
piano.tune()
// this code is invalid
// same reason like code 4 above

// 6.
class Beach {
	var lifeguards = 10
	mutating func addLifeguards(count: Int) {
		lifeguards += count
	}
}
var beach = Beach()
beach.addLifeguards(count: 2)
// this code is invalid
// this is a class, there’s no "mutating func" in class

// 7.
struct Kindergarten {
	var numberOfScreamingKids = 30
	mutating func handOutIceCream() {
		numberOfScreamingKids = 0
	}
}
let kindergarten = Kindergarten()
kindergarten.handOutIceCream()
// nice try, but this code is still invalid
// constant struct CANNOT have variable properties changed

// 8.
class Light {
	var onState = true
	func toggle() {
		if onState {
			onState = false
		} else {
			onState = true
		}
		print("Click!")
	}
}
let light = Light()
light.toggle()
// this code is valid
// constant class can have variable properties changed

// 9.
struct Code {
	var numberOfBugs = 100
	mutating func fixBug() {
		numberOfBugs += 3
	}
}
var code = Code()
code.fixBug()
// this code is valid
// variable struct can have variable properties changed

// 10.
class Phasers {
	var energyLevel = 100
	func firePhasers() {
		if energyLevel > 10 {
			print("Firing!")
			energyLevel -= 10
		}
	}
}
var phasers = Phasers()
phasers.firePhasers()
// this code is valid
// variable class can have variable properties changed

// 11.
class Sun {
	var isNova = false
	func goNova() {
		isNova = true
	}
}
let sun = Sun()
sun.goNova()
// this code is valid
// constant class can have variable properties changed

// 12.
struct Barbecue {
	var charcoalBricks = 20
	mutating func addBricks(_ numbers: Int) {
		charcoalBricks += number
	}
}
var barbecue = Barbecue()
barbecue.addBricks(4)
// this code is valid
// variable struct can have variable properties changed