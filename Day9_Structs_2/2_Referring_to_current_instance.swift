// 2. Referring to the current instance

// When creating init(), if it takes in params with the same name as vars in the struct, use the "self" keyword
// So that self.name refers to the property of the struct
// Whereas name refers to the param declared with init()

// Sample code from Paul Hudson
struct Person {
	var name: String
	init(name: String) {
		print("\(name) was born!")
		self.name = name
		// self.name refers to var "name" of struct Person
		// name refers to param "name" passed when creating struct
	}
}


////////////////////////////////////////////////////////////////
// Some extra code samples from mini test questions
struct Cottage {
	var rooms: Int
	var rating = 5
	init(rooms: Int) {
		self.rooms = rooms
	}
}
let bailbrookHouse = Cottage(rooms: 4)
// this code is valid because even tho rating wasn’t defined in init(), it was given a value right away anyway