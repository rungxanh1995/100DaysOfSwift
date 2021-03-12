// 6. Capturing values with closures

// Sample code from Paul Hudson
func travel() -> (String) -> Void {
	var counter = 0
	return {
		print("I’m going to \($0).")
		counter += 1
	}
}
let result = travel()
result("London")
result("Barcelona")
result("Paris")

////////////////////////////////////////////////////////////
// My code and personal notes
// Define a func that utilizes a closure
// The closure also keep tracks of a var defined within that func
func activity() -> (String) -> String {
	// Declare the var in this func
	var counter: Int = 0
	// Closure capturing happens when a var is defined in the func…
	return {
		// …then that var also gets used inside the closure
		counter += 1
		return "\(counter). I’m going to \($0)."
	}
}
let output = activity()
print(output("brush teeth"))
print(output("cook"))
print(output("take a nap"))
