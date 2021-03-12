// 4. Final classes
// Swift allows prevention of a class being inherited using "final"
// so that noone can build their own classes based on yours
// & they can’t override your methods to change their behaviors

// Sample code from Paul Hudson
final class Dog {
	var name: String
	var breed: String
	init(name: String, breed: String) {
		self.name = name
		self.breed = breed
	}
}