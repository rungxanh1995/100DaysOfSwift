// 4. Force unwrapping
// More code examples from mini test questions & explanations
// Question: Which of these won’t crash your code when they’re run?

// 1.
// Option 1:
let legoBricksSold: Int? = 400_000_000_000
let numberSold = legoBricksSold!
// Option 2:
func goals(for players: String) -> Int? {
	print("Sorry, the system is down right now.")
	return nil
}
let harryGoals = goals(for: "Harry Kane")!
// Ans: option 1, because the optional was given a regular Int; whereas option 2 returns nil regardless so force unwrapping it will crash

// 2.
// Option 1:
func describe(array: [String]?) {
	let unwrapped = array!
	print("The array has \(unwrapped.count) items.")
}
describe(array: [])
// Option 2:
let password: String? = nil
let unwrappedPassword = password!
// Ans: option 1, because at least the array passed in was empty, not nil. But this IMO is still not safe to force unwrap
// Option 2 was deliberately set to nil so it’d definitely crash

// 3.
// Option 1:
func population(of city: String) -> Int? {
	if city == "Paris" {
		return 2_200_000
	}
	return nil
}
let pop = population(of: "Tokyo")!
// Option 2:
let age: Int = 21
let allowedMessage: String? = age > 21 ? "Welcome!" : nil
let result = allowedMessage!
// Ans: option 2, because the string optional was returned with "Welcome!", not a nil; whereis option 1 returns a nil.
// Force unwrapping here is unsafe

// 4.
// Option 1:
func league(for skillLevel: Int) -> Int? {
	switch skillLevel {
		case 1:
			fallthrough
		case 2:
			return 3
		case 3:
			return 2
		case 4:
			return 1
		default:
			return nil
	}
}
let allocatedLeague = league(for: 3)!
// Option 2:
class Player {
	var name: String = "Anonymous"
	var salary: Int?
}
let player = Player()
let salary = player.salary!
// Ans: Option 1, because it returns 2 from case 3; whereas option 2 force unwraps the salary and finds a default nil

// 5.
// Option 1:
struct User {
	var name: String?
	var age: Int?
}
let taylor = User(name: "Taylor", age: 26)
let taylorAge = taylor.age!
// Option 2:
struct Starship {
	var name: String? = "Unknown"
	var maxWarpSpeed: Double?
}
let voyager = Starship()
let maxWarp = voyager.maxWarpSpeed!
// Ans: Option 1 won’t crash as the optional Int was given a value of 26; whereas option 2’s maxWarpSpeed optional got a default nil thus force unwrapping crashes the code

// 6.
// Option 1:
func title(for age: Int) -> String? {
	guard page >= 1 else {
		return nil
	}
	let pageCount = 132
	if page < pageCount {
		return "Page \(page)"
	} else {
		return nil
	}
}
let pageTitle = title(for: 16)
// Option 2:
let score = "babylon5"
let scoreInt = Int(score)!
// Ans: option 1
// The guard statement in option 1 has correct syntax, as "page >= 1" is a conditional, and guard deals with that conditional
// The force unwrapping there works fine as long as value passed in to the func’s param is within 1...131
// Whereas option 2 clearly crash 'cause there’s no way converting chracters to Int
