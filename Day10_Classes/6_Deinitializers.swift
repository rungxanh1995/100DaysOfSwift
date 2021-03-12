// 6. Deinitializers
// Deinit is code run after a class instance is destroyed

// Sample code from Paul Hudson
class Person {
	var name = "John Doe"
	
	init() {
		print("\(name) is alive!")
	}
	func printGreeting() {
		print("Hello, I’m \(name)")
	}
	deinit {
		// This code is run when the Person instance is being destroyed
		// Note that deinit doesn’t come with ()
		print("\(name) is no more!")
	}
}
// Create a few instances inside a loop
// Each time the loop iterates, the instance is created then destroyed
for _ in 1...3 {
	let person = Person()
	person.printGreeting()
}