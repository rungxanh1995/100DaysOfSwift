// 1. Create your own classes

// Sample code from Paul Hudson
class Dog {
	var name: String
	var breed: String
	init(name: String, breed: String) {
		self.name = name
		self.breed = breed
	}
}

////////////////////////////////////////////////////////////////
// Personal notes
// Classes seems similar to struct as it allows creation of new types with properties & methods
// But there are 5 main differences between them
// First one is Classes don’t have memberwise init() so you must establish it yourself
// Create instances of a class looks the same as if it were a struct
let mick = Dog(name: "Mick", breed: "Chihuahua")

// Other diffs
// 1 class can inherit from another class, gaining its properties & methods
// Copies of struct are always unique, while those of classes point to the same shared data
// Classes have deinitializers called when an instance of the class is destroyed, while structs don’t
// Var properties in constant classes can be modded freely, while those in constant structs cannot