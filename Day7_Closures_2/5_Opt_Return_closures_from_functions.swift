// 5 Optional. Returning closures from functions

// Sample code from Paul Hudson
// Create a number generator that gives random Ints
func makeRandomGenerator() -> () -> Int {
	let function = { Int.random(in: 1...10) }
	return function
}
let generator = makeRandomGenerator()
let random1 = generator()
print(random1)

/////////////////////////////////////////////////////////////////

// My code and personal notes
// Define the number generator func
// It takes in a closure and gets returned an Int
// Meanwhile the closure doesn’t take in anything
func getRandomNumber() -> () -> Int {
	// Define the closure here and assign to a const
	let randomNumber = {
		Int.random(in: 1...10)
	}
	// Return value of randomNumber to the main func
	return randomNumber
}
// Call the func and assign to the output number
// Using syntax 1
let random = getRandomNumber()
let outputNumber1 = random()
print(outputNumber1)
// Using syntax 2
let outputNumber2 = getRandomNumber()()
print(outputNumber2)