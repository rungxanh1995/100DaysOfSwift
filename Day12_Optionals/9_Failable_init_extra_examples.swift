// 9. Failable init
// Code examples from mini test questions
// Question: these codes will return a constant set to nil - T/F?

// 1.
struct Password {
	var text: String
	init?(input: String) {
		if input.count < 6 {
			print("Password too short")
			return nil
		}
		text = input
	}
}
let password = Password(input: "hell0")
// true, the code is valid, and "password" is returned nil by init?

// 2.
var hasForcePowers = "true"
let convertedHasForcePowers = Bool(hasForcePowers)
// false, as string "true" can be converted to bool true, the constant’s value is true, not nil

// 3.
struct Website {
	var url: String
	init?(url: String) {
		if url.hasPrefix("http") {
			self.url = url
		} else {
			print("Invalid website URL.")
			return nil
		}
	}
}
let site = Website(url: "https://www.hackingwithswift.com")
// false, as the code is valid, the instance is valid, it’s optional value is set to the passed string, not nil

// 4.
var highestJump = "2.45"
let convertedHighestJump = Double(highestJump)
// false, string "2.45" can be converted to an optional Double, not nil

// 5.
struct DEFCONRating {
	var number: Int
	init?(number: Int) {
		guard number > 0 else { return nil }
		guard number <= 5 else { return nil }
		self.number = number
	}
}
let defcon = DEFCONRating(number: 6)
// true, as number 6 didn’t pass the 2nd guard code, it’s value is set to nil by init? of the func, hence defcon = nil

// 6.
var enabled = "False"
let convertedEnabled = Bool(enabled)
// true, "False" with capital "F" cannot be converted to bool false, hence convertedEnabled is assigned a nil by init? of Bool()

// 7.
class Camel {
	var humps: Int
	init?(humpCount: Int) {
		guard humpCount <= 2 else { return nil }
		humps = humpCount
	}
}
let horse = Camel(humpCount: 0)
// false, init? returns an optional Camel to the constant, not nil

// 8.
var rating = "5 stars"
let convertedRating = Int(rating)
// true, init? of Int() returns a nil to the constant

// 9.
var powerUsage = "0,1"
let convertedPowerUsage = Double(powerUsage)
// true, a "0,1" with the comma is not convertible to an optional Double, so it’s nil

// 10.
var examResult = "100"
let cvonvertedExamResult = Int(examResult)
// false, Int() returns an optional Int, not nil

// 11.
class Hotel {
	var starRating: Int
	init?(rating: Int) {
		if rating <= 1 {
			print("This probably has bed bugs.")
			return nil
		}
		self.starRating = rating
	}
}
let hotelElan = Hotel(rating: 1)
// true, init?() returns a nil from the if code to the constant

// 12.
struct Language {
	var code: String
	init?(code: String) {
		if code.hasPrefix("en-") {
			self.code = code
		} else {
			print("Sorry, only English variants are supported.")
			return nil
		}
	}
}
let language = Language(code: "en-GB")
// false, the constant is a valid optional Language, not a nil
