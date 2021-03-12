// 4. Static properties and methods

// Ask Swift to share specific properties/methods across ALL instances of the struct by declaring them as "static"
struct Student {
	// Making classSize static
	static var classSize = 0
	var name: String
	init(name: String) {
		self.name = name
		Student.classSize += 1
	}
}
let ed = Student(name: "Ed")
let taylor = Student(name: "Taylor")
Student.classSize
// Each time a new instance (student) is created, classSize got incremented
// Since there are 2 instances called, classSize is 2


///////////////////////////////////////////////////////////////////
// Extra examples from mini test questions & explanations
// 1.
struct Question {
	static let answer = 42
	var questionText = "Unknown"
	init(questionText: String, answer: String) {
		self.questionText = questionText
		self.answer = answer
	}
}
// this code is invalid, and has 3 problems
// 1. param "answer" in init() was declared as String, which must’ve been Int
// 2. because property "answer" of the struct is a static one, calling it in init() must’ve been "Question.answer = answer"
// 3. even if coded like 2., we must change property "answer" to "var", not "let" to make it mutable

// 2.
struct NewsStory {
	static var breakingNewsCount = 0
	static var regularNewsCount = 0
	var headline: String
	init(headline: String, isBreaking: Bool) {
		self.headline = headline
		if isBreaking {
			NewsStory.breakingNewsCount += 1
		} else {
			NewsStory.regularNewsCount += 1
		}
	}
}
// this code is valid, and is really interesting and relatable

// 3.
struct PlayingCards {
	static let deckSize
	var pictureStyle: String
}
// this code is invalid, because deckSize needs either a type annotation or an initial value (then its type gets inferred)

// 4.
struct Cat {
	static let allCats = [Cat]()
	init() {
		Cat.allCats.append(self)
	}
	static func chorus() {
		for _ in allCats {
			print("Meow!")
		}
	}
}
// this code though new to me atm, but it’s still invalid, because allCats was defined as a static constant, should’ve been "var"
// create instances of this struct, and get access to its property/method like below
let cat1 = Cat()
let cat2 = Cat()
Cat.allCats
// this returns output "[Cat, Cat]"
Cat.chorus()
// this returns output
// "Meow!"
// "Meow!"

// 5.
struct Person {
	static var population = 0
	var name: String
	init(personName: String) {
		name = personName
		population += 1
	}
}
// this code is invalid because of the syntax to refer static property "population"
// should be "Person.population"

// 6.
struct FootballTeam {
	static let teamSize = 11
	var players: [String]
}
// this code is valid

// 7.
struct Pokemon {
	static var numberCaught = 0
	var name: String
	static func catchPokemon() {
		print("Pokemon caught!")
		Pokemon.numberCaught += 1
	}
}
// this code is valid

// 8.
struct Raffle {
	var ticketUsed = 0
	var name: String
	var tickets: Int
	init(name: String, tickets: Int) {
		self.name = name
		self.tickets = tickets
		Raffle.ticketUsed += tickets
	}
}
// this code is invalid because ticketUsed wasn’t declared static