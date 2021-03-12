// Day 12 summary: Optionals
// Optionals let us represent the absence of a value in a clear and unambiguous way.
// Swift won’t let us use optionals without unwrapping them, either using if let or using guard let.
// You can force unwrap optionals with an exclamation mark, but if you try to force unwrap nil your code will crash.
// Implicitly unwrapped optionals don’t have the safety checks of regular optionals.
// You can use nil coalescing to unwrap an optional and provide a default value if there was nothing inside.
// Optional chaining lets us write code to manipulate an optional, but if the optional turns out to be empty the code is ignored.
// You can use try? to convert a throwing function into an optional return value, or try! to crash if an error is thrown.
// If you need your initializer to fail when it’s given bad input, use init?() to make a failable initializer.
// You can use typecasting to convert one type of object to another.

// More code examples from mini test questions
// Question: these codes are valid in Swift - T/F?

// 1.
func mowGrass(to height: Double?) {
	guard let height = height else { return }
	print("Mowing the grass to \(height).")
}
mowGrass(to: 6.0)
// true, the code is valid
// guard let unwraps the passed in value of param height and sees it’s a regular Double, hence the print statement is still executed

// 2.
let coffee: String? = "Cappucino"
let unwrappedCoffee: String = coffee!
// true, the code is valid
// the optional "coffee" is assigned a regular String
// hence force unwrapping it & assign to a regular String constant of "unwrappedCoffee" is safe

// 3.
func process(order: String) {
	print("OK, I’ll get your \(order).")
}
let pizzaRequest: String! = "pizza"
process(order: pizzaRequest)
// true, this code is valid by the way it’s coded
// another alternative to understand it better
// let pizzaRequest: String? = "pizza"
// process(order: pizzaRequest!)

// 4.
enum NetworkError: Error {
	case insecure
	case noWifi
}
func downloadData(from url: String) -> String {
	if url.hasPrefix("https://") {
		return "This is the best Swift site ever!"
	} else {
		throw NetworkError.insecure
	}
}
if let data = try? downloadData(from: "https://www.hackingwithSwift.com") {
	print(data)
} else {
	print("Unable to fetch the data.")
}
// false, this code is invalid
// missing "throws" making the func unable to throw errors

// 5.
let owlVariety: String? = nil
print(owlVariety ?? "Unknown owl")
// true, this code is valid
// basically the nil coalescing operator checks & sees owlVariety being nil, so it returns the fallback value of string "Unknown owl"
// no need to assign the whole phrase’s value to a var like prev code examples from Nil coalescing read

// 6.
struct Furniture { }
struct DeckChair: Furniture { }
let chair = DeckChair()
if let furniture = chair as? Furniture {
	print("This is furniture.")
}
// false, the code is invalid
// struct doesn’t inherit another struct, only protocols

// 7.
struct Dog {
	var name: String
	init?(name: String) {
		guard name == "Lassie" else {
			print("Sorry, wrong dog!")
			return nil
		}
		self.name = name
	}
}
let dog = Dog(name: "Fido")
// true, this code is valid

// 8.
let names = ["John", "Paul", "George", "Ringo"]
let upperRingo = names.last.uppercased()
// false, the code is invalid
// as "last" property is an optional -> the optional chaining fails
// should be coded as "names.last?.uppercased()"

// 9.
let birthYear: Int? = nil
let year = birthYear ? "Unknown"
// false, this code is invalid, and has 2 problems
// 1st one is nil coalescing operator is "??", not "?"
// 2nd is year is inferred to be an Int, not a String to fall back to "Unknown"

// 10.
let cat: String? = "Toby"
if let cat = cat {
	print("The cat’s name is \(cat).")
}
// true, the code is valid
// if let unwraps the 1st "cat" & sees a string value
// making the conditional true -> print statement is executed

// 11.
let doctor: String? = "Dr Singh"
let assignedDoctor: String = doctor?
// false, invalid code due to invalid syntax with "doctor?"
// could’ve been "let assignedDoctor: String = doctor!"

// 12.
func brewBeer(to stregnth: Double?) {
	guard strength = strength else { return }
	print("Let’s brew some beer!")
}
brewBeer(to: 5.5)
// false, the code is invalid
// missing "let" with the guard code
// btw "guard" w/o "let" is used in failable init
