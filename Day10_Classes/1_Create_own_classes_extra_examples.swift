// 1. Create your own classes
// More code examples from mini test questions
// Question: These code defines a valid class - T/F?

// 1.
class Painting {
	var title: String
	var artist: String
	var paintType: String
	func init(title: String, artist: String, paintType: String) {
		self.title = title
		self.artist = artist
		self.paintType = paintType
	}
}
// this code is invalid because there’s a "func" before init()

// 2.
class BoardGame {
	var name: String
	var minimumPlayers = 1
	var maximumPlayers = 4
	init(name: String) {
		self.name = name
	}
}
// this code is valid and defines a class
// because despite init() not taking in min and max players, their values & inferred data type were already established upfront

// 3.
struct Sandwich {
	var name: String
	var fillings: [String]
}
let blt = Sandwich(name: "BLT", fillings: ["Bacon", "Lettuce", "Tomato"])
// this code defines a struct but not a class, albeit valid

// 4.
class TIE {
	var name: String
	var speed: Int
	init(name: String, speed: Int) {
		self.name = name
		self.speed = speed
	}
}
let fighter = TIE(name: "TIE Fighter", speed: 50)
let intercepter = TIE(name: "TIE Interceptor", speed: 70)
// this code is valid and defines a class

// 5.
class VideoGame {
	var hero: String
	var enemy: String
	init(heroName: String, enemyName: String) {
		self.hero = heroName
		self.enemy = enemyName
	}
}
let monkeyIsland = VideoGame(heroName: "Guybrush TThreewood", enemyName: "LeChuck")
// this code is valid and defines a class

// 6.
class Image {
	var filename: String
	var isAnimated: Bool
	init(filename: String, isAnimated: Bool) {
		filename = filename
		isAnimated = isAnimated
	}
}
// this code is invalid
// as params passed to init() have the same name with class properties, Swift requires "self" to distinguish

// 7.
class ThemePark {
	var entryPrice: Int
	var rides: [String]
	init(rides: [String]) {
		self.rides = rides
		self.entryPrice = rides.count * 2
	}
}
// this code is valid and defines a class
// because tho init() got passed in only param rides, the value of entryPrice still got defined within scope of init()

// 8.
struct Poll {
	var question: String
	var option1: String
	var option2: String
	var votes: [Int]
}
let question = "Jet black or rose gold?"
let poll = Poll(question: question, option1: "Jet black", option2: "Rose gold", votes: [0, 0, 0, 0, 1, 0, 1])
// this code is valid, but defines a struct (with memberwised init), not a class

// 9.
struct Empty { }
let nothing = Empty()
// this code tho boring and odd, is still valid as a class

// 10.
class Attendee {
	var badgeNumber = 0
	var name = "Anonymous"
	var company = "Unknown"
	init(badge: Int) {
		self.badgeNumber = badgeNumber
	}
}
// this code is invalid, because it should read "badgeNumber = badge" or "self.badgeNumber = badge"

// 11.
class Podcast {
	var hosts: [String]
	init(hosts: [String]) {
		self.hosts = hosts
	}
}
// this code is valid and defines a class

// 12.
class Singer {
	var name: String
	var favoriteSong: String
	init(name: String, song: String) {
		self.name = name
		self.song = song
	}
}
let taylor = Singer(name: "Taylor Swift", song: "Blank Space")
// this code is invalid, because it should be "favoriteSong = song" or "self.favoriteSong = song"

