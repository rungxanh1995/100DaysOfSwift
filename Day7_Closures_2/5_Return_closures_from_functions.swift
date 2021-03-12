// 5. Returning closures from functions

// Sample code from Paul Hudson
// Define func that accepts no params, but return a closure
// That closure must be called with a String, and returns nothing
func travel() -> (String) -> Void {
	return {
		print("I’m going to \($0).")
	}
}
// Call travel() to get back that closure, then call it as a func
let result = travel()
result("London")

// Also can call the return value from travel() directly
let result2 = travel()("London")

/////////////////////////////////////////////////////////////////

// My code and personal notes
// Define func that returns a closure
// With that closure must also took in 2 Strings and returns a Bool
func travel() -> (String, String) -> Bool {
	return {
		// A hidden "return" keyword isn’t needed if only 1 line of code
		// This closure get passed in 2 aforementioned Strings
		print("I’m going to \($0) at \($1).")
		if $1 == "dawn" { return true }
		else { return false }
	}
}
// Define output result using syntax of "result2" from Paul’s code
let output = travel()("London", "dawn")
// Define 2 String params to pass into the closure
let destination = "Toronto"
let time = "dawn"
// Print out the output
print("My friend would meet me at the airport? \(output)")

// Output from the console
// I’m going to London at dawn.
// My friend would meet me at the airport? true
