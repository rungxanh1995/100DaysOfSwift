// 3. When to use guard let rather than if let

// guard let is designed to EXIT the current func, loop, condition if the check FAILS
// any values you unwrap using guard let stay around after the check, outside of guard let code

// Code to demonstrate the statement above
// Define the 1st func that returns an optional Int
func getInt() -> Int? {
	12
}
// Create another func to call the 1st func
func printInt() {
	// Use if let to just unwrap the optional from getInt()
	if let outputInt = getInt() {
		// Proof that unwrapped outputInt stays within if let
		print("\(outputInt) stays inside of if let scope.")		
	}
	// Proof that unwrapped outputInt DOESN’T stay outside if let
	print("\(outputInt) stays outside of if let scope.")
	// this code is invalid and won’t print out anything
	
	// Alternatively, use guard let to unwrap the optional
	guard let outputInt = getInt() else {
		// Exit the func immediately if the condition isn’t true
		// MUST use keyword "return"
		return
	}
	// else if true, print message that the unwrapped stays outside guard let
	print("\(outputInt) stays outside guard let scope.")
}

// 2 important things have changed using guard let:
// It lets us focus on the behavior of our func when everything has gone to plan (the optional isn’t nil)
// guard requires that we exit the current scope when it’s used,  aka we must return from the func if it fails.
