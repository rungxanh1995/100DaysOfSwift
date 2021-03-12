// 8. Optional try

// Back in #Day5 w/ "Throwing functions" there was this code
// Using throws, try, and catch to throw an error when smth isn’t right, and to handle errors

// Code sample from Paul Hudson back then
enum PasswordError: Error {
	case obvious
}
func checkPassword(_ password: String) throws -> Bool {
	if password == "password" {
		throw PasswordError.obvious
	}
	return true
}
do {
	try checkPassword("password")
	print("That password is good!")
} catch {
	print("You can’t use that password.")
}

// Now that we know about optionals
// There’s a "try?" that convert a throwing function call into an optional
// Using it like this
if let result = try? checkPassword("password") {
	print("Result was (result)")
} else {
	print("D’oh.")
}
// This prints "D’oh." as the if let code unwraps the try? returned value & sees a nil, making the conditional not true

// Personally I see this is still quite hard to get
// There’s another way to see it -> replace Paul’s if let with
if ((try? checkPassword("password")) != nil) {
	print("Password is okay!")
} else {
	print("Bad password!")
}
// try? first executes checkPassword() & sees a thrown error
// it then decides a return value of nil
// (try? checkPassword("password")) is now nil
// hence the else code runs

// Alternatively there’s a try! to force unwrap the returned optional
// Only use when you’re sure it won’t return a nil
// Otherwise the entire code crashes!
try! checkPassword("password")
// This code would crash, because it returned a nil