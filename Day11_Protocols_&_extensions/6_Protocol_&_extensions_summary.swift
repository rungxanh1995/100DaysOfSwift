// 6. Protocols & extensions summary
// Code samples from mini test questions & explanations
// Question: these code are valid in Swift - T/F?

// 1.
protocol HasAge {
	var age: Int { get set }
	mutating func celebrateBirthday()
}
// true, and the method was defined as mutating from the very start, which is valid

// 2.
protocol Paintable { }
protocol Tileable { }
struct Wall: Paintable, Tileable { }
// true, the code is valid though empty

// 3.
extension Collection {
	func describe() {
		if count == 1 {
			print("There’s 1 item.")
		} else {
			print("There are \(count) items.")
		}
	}
}
// true, the code is valid as Collection is a built-in protocol

// 4.
protocol Ridable
protocol Trainable
protocol Dog: Trainable
// false, even empty protocols need empty braces { }

// 5.
protocol NotAMoon { }
protocol HasExhaustPort { }
struct DeathStar: NotAMoon HasExhaustPort { }
// false, missing a comma in between protocols’ name

// 6.
protocol CanFly {
	var maximumFlightSpeed: Int { get set }
}
protocol CanDrive {
	var maximumDrivingSpeed: Int { get set }
}
struct FlyingCar: CanFly, CanDrive { }
// false, the code is invalid
// you can only leave the braces of struct FlyingCar blank if the protocols it conforms to also have empty code
// otherwise, you must define ALL properties from conformed protocols

// 7.
protocol TravelsThroughTime {
	mutating func travel(to year: Int)
}
protocol BiggerOnTheInside {
	func findSwimmingPool()
}
protocol TARDIS: TravelsThroughTime BiggerOnTheInside {
	var doctorNumber: Int { get set }
}
// false, missing a comma to separate the protocols that TARDIS is inheriting

// 8.
protocol Inflatable {
	mutating func refillAir()
}
extension Inflatable {
	mutating func refillAir() {
		print("Refilling the air.")
	}
}
// true, the code is valid

// 9.
protocol SuitableForKids {
	var minimumAge: Int { get set }
	var maximumAge: Int { get set }
}
protocol SupportsMultiplePlayers {
	var minimumPlayers: Int { get set }
	var maximumPlayers: Int { get set }
}
struct FamilyBoardGame: SuitableForKids, SupportsMultiplePlayers {
	var minimumAge = 3
	var maximumAge = 110
	var minimumPlayers = 1
	var maximumPlayers = 4
}
// true, the protocols were created correctly, and the struct conforming to them also defined all comformed properties

// 10.
protocol Adjustable {
	mutating func adjustValue(by amount)
}
// false, missing typo annotation to the param

// 11.
protocol HasPages {
	var pageCount: Int
}
protocol HasTableOfContents {
	var titles: [String]
}
protocol Book: HasPages, HasTableOfContents {
	var author: String
}
// false, this question was tricky
// but note that a protocol’s properties MUST be described with getters and setters

// 12.
protocol Identifiable {
	var id: Int { get set }
}
// true, this code is valid
