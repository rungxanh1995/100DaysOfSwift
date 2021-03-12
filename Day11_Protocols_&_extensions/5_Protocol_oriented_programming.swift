// 5. Protocol-oriented programming

// Protocol extensions provide default implementations for our own protocol methods
// This allows "protocol-oriented programming" where programmers craft their code around protocols & protocol extensions

// Sample code from Paul Hudson
// First create a protocol with a property & method
protocol Identifiable {
	var id: String
	func identify()
}
// Though we COULD make every conforming type write their own identify() method…
// … a protocol extension provides a default
extension Identifiable {
	func identify() {
		print("My ID is \(id).")
	}
}
// Now when we create a conforming type to Identifiable
// it gets identify(() automatically
struct User: Identifiable {
	var id: String
}
let twostraws = User(id: "twostraws")
twostraws.identify()
// this prints "My ID is twostraws."
