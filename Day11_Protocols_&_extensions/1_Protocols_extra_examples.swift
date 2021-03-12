// 1. Protocols
// Extra code examples from mini test question & explanations
// Question: these a valid protocols - T/F?

// 1.
protocol Swimmable {
	var depth { get }
}
// invalid: depth needs a type annotation

// 2.
protocol Purchasable {
	var price: Double { get set }
	var currency: String { get set }
}
// valid

// 3.
protocol Climable {
	var height: Double { get }
	var gradient: Int { get }
}
// valid

// 4.
protocol Mailable {
	var width: Double { get, set }
	var height: Double { get, set}
}
// invalid: there were commas between get and set

// 5.
protocol Strokable {
	fluffiness: Int { get }
}
// invalid: flufiness needs to be declared with "var"

// 6.
protocol Learnable {
	var difficulty: Int { get }
}
// valid

// 7.
protocol Washable {
	var dirtinessLevel: Int { get set }
}
// valid

// 8.
struct Knittable {
	var needleSizes: [Double] { get set }
}
// invalid: either define it as a struct without get set, or as a protocol

// 9.
protocol Singable {
	var lyrics: [String] { get set }
	var notes: [String] { get set }
}
// valid

// 10.
protocol Plantable {
	var requirements: [String] { get set }
}
// valid

// 11.
protocol Buildable {
	var numberOfBricks: Int { set }
	var materials: [String] { set }
}
// invalid: cannot create set-only properties
// but get-only properties is ok
// Xcode would say "Variable with a setter must also have a getter"

// 12.
protocol Liftable {
	var weight: Double get set
}
// invalid: missing braces around get set
