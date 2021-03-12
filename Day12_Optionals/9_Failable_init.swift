// 9. Failable init

// A failable init() is one that might work or might not
// Could be used as a validation check for a struct/class
// It returns an optional instance that’s nil when init failed
// 2 steps to define a failable init()
// 1. Code it as init?() instead of init()
// 2. Return nil for any paths that should fail

// You also can define as many  nil(s) as you need
// The path that doesn’t return a nil is assumed to be having no problem


///////////////////////////////////////////////////////////////////
// 3 examples to understand this further

// Example 1
let str1 = "5"
let str2 = "str2"
let num1 = Int(str1)
// This returns an Optional(5)
let num2 = Int(str2)
// This returns a nil
// Because Int() was defined to also return a nil for the path where it can’t convert a string to an integer
// So the init of Int() is called a failable init

// Example 2
struct Person {
	var id: String
	init?(id: String) {
		if if.count == 9 {
			self.id = id
		} else {
			return nil
		}
	}
}
// Any instance of this struct is ONLY valid when its "id" count is exactly 9, otherwise it doesn’t pass the "validation check" by init?() & the instance is then set as nil
let validPerson = Person(id: "123456789") // Valid instance
let invalidPerson = Person(id: "12345") // Invalid instance -> nil

// Example 3
struct Employee {
	var username: String
	var password: String
	init?(username: String, password: String) {
		// Guard code to play as validation checks
		guard password.count >= 8 else { return nil }
		guard password.lowercased() != "password" else { return nil }
		
		// Define self properties as usual
		self.username = username
		self.password = password
	}
}
// Create 2 instances to double check if init?() works
let tim = Employee(username: "TimC", password: "apple")
// This instance is invalid because "password" didn’t "pass" the check therefore the instance is nil
let craig = Employee(username: "CraigF", password: "h@1rf0rceO")
// This instance is valid

// Last point: it’s much safer to implement failable init instead of a separate check method, because it’s too easy to forget to call the other method
