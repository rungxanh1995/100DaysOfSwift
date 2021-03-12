// 3. Overriding methods
// Sample code from Paul Hudson
class Dog {
	func makeNoise() {
		print("Woof!")
	}
}
class Poodle: Dog {
	override func makeNoise() {
		print("Yip!")
	}
}
let poppy = Poodle()
poppy.makeNoise()
// this prints out "Yip!"

/////////////////////////////////////////////////////////////////
// Extra examples from mini test questions * explanations
// Question: these codes will print some sort of output - T/F?

// 1.
class Appliance {
	func start() {
		print("Starting...")
	}
}
class Oven: Appliance {
}
let oven = Oven()
oven.start()
// true: this code prints out "Starting..."

// 2.
class Band {
	func singSong() {
		print("Here’s a new song.")
	}
}
class MetalBand: Band {
	override func singSong() {
		print("Ruuuuh ruh ruh ruuuuuh!")
	}
}
let lordi = MetalBand()
lordi.singSong()
// true: this code prints out "Ruuuuh ruh ruh ruuuuuh!"

// 3.
class Watch{
	func tellTime() {
		print("It’s 9:41")
	}
}
class SmartWatch: Watch {
	override func tellTime() {
		print("It’s 9:41")
	}
}
let appleWatch = SmartWatch()
appleWatch.tellTime()
// true: tho the overriden tellTime() of class SmartWatch was defined similarly, it’s still valid, and prints out its content

// 4.
class Building {
	override func build() {
		print("This will take a couple of months.")
	}
}
class Skyscrapper: Building {
	override func build() {
		print("This will take a year.")
	}
}
let shanghaiTower = Skyscrapper()
shanghaiTower.build()
// false: there are 2 issues
// class Building was defined as a parent class, but its func says override. so there’s nothing inherited to override from

// 5.
class Composer {
	func composeMusic() {
		print("Here’s some music I wrote.")
	}
}
class OperaComposer: Composer {
	override func composeMusic() {
		print("Here’s an opera I wrote.")
	}
}
let verdi = OperaComposer()
verdi.composeMusic()
// true, this would print out "Here’s an opera I wrote."

// 6.
class Airplane: Jet {
	func takeOff() {
		print("Fasten your seatbelts.")
	}
}
class Jet: Airplane {
	override func takeOff() {
		print("Someone call Kenny Loggins, because we’re going into the danger zone!")
	}
}
let f14 = Jet()
f14.takeOff()
// false: this attempts to inherit 1 class from another, which is incorrect

// 7.
class Spaceship {
}
class StarDestroyer: Spaceship {
	func enterLightSpeed() {
		print("Let’s go to ludicrous speed!")
	}
}
let executor = StarDestroyer()
executor.enterLightSpeed()
// true: enterLightSopeed() wasn’t there in class Spaceship anyway, so the code is valid

// 8.
class Doctor {
	func operate() {
		print("I can’t do that.")
	}
}
class Surgeon {
	override func operate() {
		print("OK, let’s go!")
	}
}
let doogieHowser = Doctor()
doogieHowser.operate()
// false, this code won’t print out anything
// either class Surgeon be a child class of Doctor, hence override func is valid
// or remove "override" from the method of class Surgeon, in which case these 2 classes are separate from each other

// 9.
class Cinema {
	func showMovie() {
		print("Get your popcorn ready!")
	}
}
class IMAXCinema: Cinema {
	func showMovie() {
		print("Get your eardrums ready!")
	}
}
let londonIMAX = IMAXCinema()
londonIMAX.showMovie()
// false, method of IMAXCinera should be declared using override

// 10.
class Exercise {
	func describe() {
	}
}
class ChinUps: Exercise {
	override func describe() {
	}
}
let firstRep = ChinUps()
firstRep.describe()
// false: though the code is totally valid, it prints nothing

// 11.
class Store {
	func restock() -> String {
		return "Fill up the empty shelves."
	}
}
class GroceryStore: Store {
	override func restock() -> String {
		return "We need to buy more food."
	}
}
let tesco = GroceryStore()
tesco.restock()
// false: though the code is totally valid, it prints nothing
