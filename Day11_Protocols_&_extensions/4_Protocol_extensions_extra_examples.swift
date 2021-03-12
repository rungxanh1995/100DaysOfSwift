// 4. Protocol extensions
// Extra code samples from mini test questions & explanations
// Question: this extension correctly implements a method from its protocol - T/F?

// 1.
protocol DogTrainer {
	func train(dog: String) {
		print("We’ll make \(dog) behave in no time!")
	}
}
// false: this code not only has no protocol extensions
// it gives code inside methods, which is invalid protocol syntax

// 2.
protocol Chef {
	func getRecipes() -> [String]
}
extension Chief {
	func getRecipes() -> [String] {
		return ["Macaroni Cheese"]
	}
}
// false: there’s a typo with "Chief". otherwise, this code defines a protocol extension correctly

// 3.
protocol SmartPhone {
	func makeCall(to name { get set })
}
extension SmartPhone {
	func makeCall(to name: String) {
		print("Dialing \(name)...")
	}
}
// false: "makeCall(to name { get set })" is totally invalid syntax

// 4.
protocol Politician {
	var isDirty: Bool { get set }
	func takeBribe()
}
extension Politician {
	func takeBribe() {
		if isDirty {
			print("Thank you very much!")
		} else {
			print("Someone call the police!")
		}
	}
}
// true: the extension correctly implements takeBribe() method from Politician

// 5.
protocol Anime {
	var availableLanguages: [String] { get set }
	func watch(in language: String)
}
extension Anime {
	func watch(in language: String) {
		if availableLanguages.contains(language) {
			print("Now playing in \(language).")
		}
		else {
			print("Unrecognized language.")
		}
	}
}
// true: the extension correctly implement watch() method from Anime

// 6.
protocol Club {
	func organizeMeeting(day: String)
}
extension Club {
	override func organizeMeeting(day: String) {
		print("We're going to meet on \(day).")
	}
}
// false: there’s no "override func" with protocol extensions

// 7.
protocol SuperHeroMovie {
	func writeScript() -> String
}
extension SuperHeroMovie {
	func makeScript() -> String {
		return """
		Lots of special effects,
		some half-baked jokes,
		and a hint of another
		sequel at the end.
		"""
	}
}
// false: the protocol describes writeScript(), while the extensions implements makeScript()

// 8.
protocol Mammal {
	func eat()
}
extension Mamma {
	func eat() {
		print("Time for dinner!")
	}
}
// true: the extension correctly implements eat() method from Mammal

// 9.
protocol Bartender {
	func makeDrink
}
extension Bartender {
	func makeDrink(name: String) {
		print("One \(name) coming right up.")
	}
}
// false: at least include () in the method description of protocol

// 10.
protocol Hamster {
	var name: String { get set }
	func runInWheel(minutes: Int)
}
extension Hamster {
	func runInWheel(minutes: Int) {
		print("\(name) is going for a run")
		for _ in 0..<minutes {
			print("Whirr whirr whirr")
		}
	}
}
// true: the extension correctly implements runInWheel method from Hamster

// 11.
protocol Starship {
	func transport(number: Int)
}
extension Starship {
	func transport(number: Int) {
		print("\(number) to beam up - energize!")
	}
}
// true: the extension correctly implements transport() method from Starship

// 12.
protocol Fencer {
	func fenceFoil()
}
extension Fencer {
	func fenceFoil() {
		print("En garde!")
	}
}
// true: the extension correctly implements fenceFoil() method from Fencer

