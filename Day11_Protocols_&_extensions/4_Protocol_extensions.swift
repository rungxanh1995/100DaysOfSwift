// 4. Protocol extensions
// Let’s jog our memory about protocols and extensions

// Protocols: let you describe what methods that something should have, but don’t provide the code in those methods
// Extensions: let you provide the code inside your methods, but only affect 1 data type - you can’t add the method to lots of types at the same time

// Hence protocol extensions: they’re like regular extensions but, rather than extending functionality of a specific type like "Int", you extend a whole protocol => all conforming types get your changes

// Sample code from Paul Hudson
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

// Both arrays & sets conform to a protocol called "Collection"
// So we write an extension to this protocol adding an extra method
extension Collection {
	func summarize() {
		print("There are \(count) of us:")
		for name in self {
			print(name)
		}
	}
}
// Now both Array & Set have this method
pythons.summarize()
// this prints out
// There are 6 of us:
// Eric
// Graham
// John
// Michael
// Terry
// Terry
beatles.summarize()
// this prints out
// There are 4 of us:
// Ringo
// George
// John
// Paul
