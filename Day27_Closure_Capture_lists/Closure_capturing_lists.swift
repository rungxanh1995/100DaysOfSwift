// 27. Capture lists in Swift
// Difference between weak, strong, unowned references

// Capture lists come before a closure’s parameter list in code
// They capture values from the environment as strong/weak/unowned
// Used to mainly avoid strong reference cycle (aka retain cycle)

// Example code from Paul Hudson

// First create a class
class Singer {
	func playSong() {
		print("Shake it off!")
	}
}

// Strong capturing in closure
func sing() -> () -> Void {
	let taylor = Singer()
	
	let singing = {
		taylor.playSong()
		// This is by default strong capturing
		// as "taylor" was used inside the closure
		// so Swift makes sure it stays alive for as long as the closure exists elsewhere in the code
		return
	}
	return singing
}
// Call the sing function
sing()()	// this prints the string "Shake it off!"


// Weak capturing in closure
func sing() -> () -> Void {
	let taylor = Singer()
	
	let singing = { [weak taylor] in
		taylor?.playSong()
		// This is now weak capturing
		// [weak taylor] is the capture list of how values should be captured
		// "taylor" instance is now an optional Singer as it would be nil after being destroyed
		return
	}
	return singing
}
// Call the sing function
sing()()
// this doesn’t print out anything, as taylor now exists only inside the sing function
// the closure it returns doesn’t keep a strong hold of it
// In fact, attempt to force unwrap "taylor!" results in code crash


// Unowned capturing
func sing() -> () -> Void {
	let taylor = Singer()
	
	let singing = { [unowned taylor] in
		taylor.playSong()
		// unowned capturing behaves like implicitly unwrapped optionals
		// like weak capturing, it allows values to become nil at any point in the future
		// but you don’t need to unwrap optionals when using unowned
		// anyway, use unowned with caution
		return
	}
	return singing
}
sing()()
// Calling the function now still result in a code crash




