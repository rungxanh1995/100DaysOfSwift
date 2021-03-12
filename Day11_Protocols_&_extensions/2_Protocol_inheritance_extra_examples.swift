// 2. Protocol inheritance
// Extra code samples from mini test questions & explanations
// Question: these code demo protocol inheritance - T/F?

// 1.
protocol MakesDiagnoses {
	func evaluate(patient: String) -> String
}
protocol PrecribesMedicine {
	func prescribe(drug: String)
}
protocol Doctor: MakesDiagnoses, PrescribesMedicine { }
// true: this code demo protocol inheritance correctly

// 2.
protocol Buyable {
	var cost: Int
}
protocol Sellable {
	func findBuyers() -> [String]
}
protocol FineArt: Buyable, Sellable { }
// false: this code doesn’t demo protocol inheritance correctly
// missing getter or getter & setter in Buyable

// 3.
protocol CarriesPassengers {
	var passengerCount: Int { get set }
}
protocol CarriesCargo {
	var cargoCapacity: Int { get set }
}
protocol Boat: CarriesPassenger, CarriesCargo {
	var name: String { get set }
}
// true: this code demo protocol inheritance correctly

// 4.
protocol GivesOrders {
	func makeItSo()
}
protocol OrdersDrinks {
	func teaEarlGrey(hot: Bool)
}
protocol StarshipCaptain: GivesOrders, OrdersDrinks { }
// true: this code demo protocol inheritance correctly

// 5.
protocol Scoreable {
	func add
}
protocol Winnable {
	func makeWinningSpeech
}
protocol Competitor: Scoreable, Winnable { }
// false: this code doesn’t demo protocol inheritance correctly
// missing () from methods of each protocol

// 6.
protocol Readable {
	func read() -> String
}
protocol Writable {
	func write(string: String)
}
protocol NetworkSocket: Readable, Writeable
// false: this code doesn’t demo protocol inheritance correctly
// missing braces {} for NetworkSocket

// 7.
protocol HasEngine {
	func startEngine()
}
protocol HasTrunk {
	func openTrunk()
}
struct Car: HasEngine, HasTrunk { }
// false: this code doesn’t demo protocol inheritance correctly
// a struct must ONLY be built from ONE protocol
// better create another protocol to inherit from those 2

// 8.
protocol HasMindTricks {
	func waveHandMystically()
}
protocol UsesForce {
	func raiseXWing()
}
protocol JediKnight: HasMindTricks, UsesForces { }
// true: this code demo protocol inheritance correctly

// 9.
protocol LikesTravel {
	func visit(place: String)
}
protocol BuySouvenirs {
	func buy(item: String)
}
protocol Tourist: LikesTravel, BuySouvenirs { }
// true: this code demo protocol inheritance correctly

// 10.
protocol HasRooms {
	var roomCount: Int { get set }
}
protocol ServesFood {
	var openingTime: Int { get set }
}
protocol Hotel: HasRooms ServesFood {
	var starRating: Int { get set }
}
// false: this code doesn’t demo protocol inheritance correctly
// missing a comma "," between HasRooms and ServesFood

// 11.
protocol TimeTraveler {
	func travel(to year: Int)
}
protocol HuntsPeople {
	func locateJohnConnor()
}
protocol Terminator: TimeTraveler, HuntsPeople { }
// true: this code demo protocol inheritance correctly

// 12.
struct Collectible {
	var rarity: Int { get set }
}
struct Tradeable {
	var condition: String { get }
}
protocol ClassicTop: Collectible, Tradeable { }
// false: this code doesn’t demo protocol inheritance correctly
// this code has 2 issues
// if is demoing protocol inheritance, then Collectible & Tradeable must be protocols, not structs, and remove getters & setters
// if is demoing struct inheritance, then only can inherit 1 struct at a time
