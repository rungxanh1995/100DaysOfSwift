// 2. Optional reading: Using closure as params when they returns value

// Sample code from Paul Hudson
func reduce(_ values: [Int], using closure: (Int, Int) -> Int) -> Int {
	// start with a total equal to the first value
	var current = values[0]
	
	// loop over all the values in the array, counting from index 1 onwards
	for value in values[1...] {
		// call our closure with the current value and the array element, assigning its result to our current value
		current = closure(current, value)
	}
	// send back the final current value
	return current
}

let number = [10, 20, 30]
let sum = reduce(numbers) { (runningTotal: Int, next: Int) in
	runningTotal + next
}
print(sum)


/////////////////////////////////////////////////////////////////
// My code and personal notes
// Write a reducer program that takes in an Int array & return their sum
// Using func and closure

// Declare the input Int array
let numberArray: Array = [1, 3, 5, 7, 9]
// Define the reducer function
// The reducerClosure would take in 2 Int params at a time & return an Int
func reducer(values: [Int], reducerClosure: (Int, Int) -> Int) -> Int {
	// Default the 1st Int of the array as default value for "current"
	var current: Int = values[0]
	// Use for loop to advance thru the next values in the Int array
	for value in values[1...] {
		// Assign the returned value of reducerClosure to "current"
		current = reducerClosure(current, value)
	}
	// Return "current" as final value to reducer()
	return current
}
// Now define the reducerClosure by calling reducer()
// The 2 Int params mentioned to feed the closure are now also defined, then assign to the output
let output = reducer(values: numberArray) { (currentValue: Int, nextValue: Int) in
	// Because params passed into closure are const, so I declare another const "total" to hold their sum
	let total = currentValue + nextValue
	return total
}
// Finally, print output as reduced value of the whole Int array
print(output)

// Output in console
// 25