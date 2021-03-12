// 7. Mutability (Opt read)

// Comparison between struct and class
// Why can variable properties be changed in a constant class
// The reasons lies in the fundamental difference between them
// Class points to some data in memory (regardless the class is variable or constant)
// While struct is one unique value, i.e. the number 5

// The way structs and classes handle mutability of properties
// Personal code also injected here
// Let’s define a struct
struct PersonStruct {
	var name = "Unknown"
	let age = 0
}
// Now a class
class PersonClass {
	var name = "Unknown"
	let age = 0
}
// Create a variable struct
var person1 = PersonStruct()
// Variable struct CAN have variable properties changed
person1.name = "Variable person struct"
// this code is valid

// Create a constant struct
let person2 = PersonStruct()
// Constant struct CANNOT have variable properties changed
person2.name = "Constant person struct"
// this code is INVALID
// Xcode says 'person2' is a 'let' constant

// Create a variable class
var person3 = PersonClass()
// Variable class CAN have variable properties changed
person3.name = "Variable person class"
// this code is valid

// Create a constant class
let person4 = PersonClass()
// Constant class CAN have variable properties changed
person4.name = "Constant personal struct"
// this code is valid

// To double check that a constant class would change the property value if it’s copied from another class instance, let’s code this
let person3Constant = person3
person3Constant.name = "Names are same regardless of variable or constant class"
// Apparently, these 2 lines of code print out the same string, because of the aforementioned reason: Class points to some data in memory (regardless the class is variable or constant)
print(person3.name)
print(person3Constant.name)