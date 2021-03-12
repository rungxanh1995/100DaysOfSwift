// 3. Unwrapping with guard let
// Code examples from mini test questions & explanations
// Question: These codes will print a message - T/F?

// 1.
func double(number: Int?) -> Int? {
	guard let number = number else {
		return nil
	}
	return number * 2
}
let input = 5
if let doubled = double(number: input) {
	print("\(input) doubled uis \(doubled).")
}
// true, this prints out the string from if let
// as doubled is an unwrapped non-nil optional

// 2.
func playOpera(by composer: String?) -> String? {
	let composer = composer else {
		return "Please specify a composer."
	}
	if composer == "Mozart" {
		return "Le nozze di Figaro"
	} else {
		return nil
	}
}
if let opera = playOpera(by:"Mozart") {
	print(opera)
}
// false, this code won’t print out anything
// syntax error below func definition, should be "guard let"
// // if let code plays as a call to playOpera() func

// 3.
func playScale(name: String?) {
	guard let name = name {
		return
	}
	print("Playing the \(name) scale.")
}
playScale(name: "C")
// false, this code won’t print out
// missing else in guard let code

// 4.
func verify(age: Int?) -> Bool {
	guard age >= 18 {
		return true
	} else {
		return false
	}
}
if verify(age: 18) {
	print("You’re old enough.")
} else {
	print("Come back in a few years.")
}
// false, this code won’t print out
// in fact, the whole guard code was a complete mess: missing guard let, missing else, attempting to perform comparison on an unwrapped optional, and even if putting "else" in guard let statement, there’d be doubled else in there
// personal suggested code fix
// func verify(age: Int?) -> Bool {
//   guard let age = age else {
//     // cannot just "return" as the func was designed to return a Bool
//     return false
//   }
//   if age >= 18 {
//     return true
//   } else {
//     return false
//   }
// }
// if verify(age: 28) {
//   print("You're old enough.")
// } else {
//   print("Come back in a few years.")
// }

// 5.
func uppercase(string: String?) -> String? {
	guard let string = string else {
		return nil
	}
	return string.uppercased()
}
if let result = uppercase(string: "Hello") {
	print(result)
}
// true, this code prints the result
// because there was actual string passed to the func
// making it’s a definite String then
// thus guard let upwrapped it and found non-nil data inside
// and return the uppercased version of the string

// 6.
func isLongEnough(_ string: String?) -> Bool {
	guard let string = string else { return false }
	if string.count >= 8 {
		return true
	} else {
		return false
	}
}
if isLongEnough("Mario Odyssey") {
	print("Let’s play that!")
}
// true, this code prints "Let’s play that!"
// same reason like code 5 above

// 7.
func add3(to number: Int) -> Int {
	guard let number = number else {
		return 3
	}
	return number + 3
}
let added = add3(to: 5)
print(added)
// false, this code doesn’t print out "added"
// because param "number" wasn’t an optional
// thus guard let didn’t serve any purpose here

// 8.
func validate(password: String?) -> Bool {
	guard let password = password else {
		return false
	}
	if password == "fr0sties" {
		print("Authenticated succesfully!")
		return true
	}
	return false
}
validate(password: "fr0sties")
// true, this code is valid, and prints "Authenticated successfully!"

// 9.
func test(number: Int?) {
	guard let number = number else { return }
	print("Number is \(number)")
}
test(number: 42)
// true, this code prints "Number is 42"

// 10.
func username(for id: Int?) -> String {
	guard let id = id else {
		return nil
	}
	if id == 1989 {
		return "Taylor Swift"
	} else {
		return nil
	}
}
if let user = username(for: 1989) {
	print("Hello, \(user)!")
}
// false, this won’t print
// the code acts as if the func would return an optional String
// it does not, it was designed to return a definite String

// 11.
func describe(occupation: String?) {
	guard let occupation = occupation else {
		print("You don’t have a job.")
		return
	}
	print("You’re an \(occupation).")
}
let job = "engineer"
describe(occupation: job)
// true, this code would print
// the func is not returning anything
// guard let was also coded correctly

// 12.
func plantTree()_ type: String?) {
	guard let type else {
		return
	}
	print("Planting a \(type).")
}
plantTree("willow")
// false: this code is invalid and won’t print the message
// missing conditional with guard let statement
// should’ve been guard let type = type
 