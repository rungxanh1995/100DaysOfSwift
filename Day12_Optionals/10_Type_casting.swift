// 10. Type casting

// Type casting is a way to check the type of an instance
// or to treat the instance as a different superclass/subclass from somewhere else in its own class hierachy

// Reason to use type casting: boils down to "type inference"
// We want to tell Swift that an object Swift thinks is type A is actually type B
// This is helpful when working w/ protocols & class inheritance

// To understand this concept better, check out this hierachy
// Define Animal as superclass
class Animal { }
// Define Fish as subclass of Animal
class Fish: Animal { }
// Define Dog as subclass of aminal
class Dog: Animal {
	func makeNoise() {
		print("Woof!")
	}
}
// Let’s define an array of Aminals
let pets = [Fish(), Dog(), Fish(), Dog()]
// This pets array is type-inferred to be one of Aminal
// as both Fish & Dog inherit from their superclass Aminal

// So when looping thru the array and want only the Dogs to make noise, we MUST perform type casting: checking whether each pet is a Dog object, if so then call makeNoise(), otherwise nil
// Use keyword "as?"
for pet in pets {
	if let dog = pet as? Dog {
		dog.makeNoise()
	}
}
// So originally Swift inferred all elements of the array as Aminals
// Type casting tells Swift to check if a pet is actually a Dog
// and those that are valid Dogs allow us access to their properties & methods


// Another example from the Optional read
class Person {
	var name = "Anonymous"
}
class Customer: Person {
	var id = 12345
}
class Employee: Person {
	var salary = 50_000
}
// Jog memory: classes require explicit init()
// but as properties are already set, no need to define them

// Create instance for the subclasses
// then add to the same array
let customer = Customer()
// This makes customer a Customer
let employee = Employee()
// This makes employee an Employee
let people = [customer, employee]
// But adding them to same array makes Swift infer them both as Person(s)
// Hence looping thru them only allow access to property "name" of superclass Person

// So type casting solve this issue
for person in people {
	if let customer = person as? Customer {
		print("I’m a customer with id \(customer.id)")
	} else if let employee = person as? Employee {
		print("I’m an employee earning $\(employee.salary)")
	}
}

// Sidenote: consider reducing the use of type casting tho, as it’s better for Swift to infer and know what type of data it’s dealing with by itself
