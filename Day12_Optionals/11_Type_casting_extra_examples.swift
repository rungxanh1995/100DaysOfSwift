// 11. Type casting
// More code examples from mini test questions
// Questrion: this code will print some output - T/F?

// 1.
class Museum {
	var name = "National Museum"
}
class HistoryMuseum: Museum { }
class ToyMuseum: Museum { }
let museum = ToyMuseum()
if let unwrappedMuseum = museum as? HistoryMuseum {
	print("This is the \(unwrappedMuseum.name)")
}
// false, "museum" was set as a ToyMuseum object, type casting it to a HistoryMuseum object would fail; therefore nothing is printed out

// 2.
class Person {
	var name = "Taylor Swift"
}
class User: Person { }
let taylor = User()
if let user = taylor as? User {
	print("\(user.name) is a user.")
}
// true, class User was defined as a subclass of Person, it inherits the "name" property; and taylor is a User object w/ access to "name"
// hence typecasting taylor as a User is ok -> it assigns the value to "user" & user.name is printed

// 3.
let flavor = "apple and mango"
if let taste = flavor as? String {
	print("We added \(taste).")
}
// true, typecasting flavor as String is correct -> the assigned "taste" value is printed

// 4.
class Phone {
	var model = "Unknown"
}
class Smartphone { }
let iPhone = Smartphone()
if let phone = iPhone as? Phone {
	print("The model is: \(phone.model)")
}
// false, this doesn’t print out
// as Smartphone doesn’t inherit from Phone -> typecasting fails

// 5.
let distances = [23, 28, 22]
if let stringDistances = distances as [String] {
	for distance in stringDistances {
		print("The distance was \(distance).")
	}
}
// false, this doesn’t print out anything
// typecasting from [Int] to unrelated type [String] always fails
// not least missing the "?" after "as"

// 6.
class Transport { }
class Train: Transport {
	var type = "public"
}
class Car: Transport {
	var type = "private"
}
let travelPlans = [Train(), Car(), Train()]
for plan ni travelPlans {
	if let train = plan as? Train {
		print("We’re taking \(train.type) transport.")
	}
}
// true, typecasting succeeded so train.type is printed

// 7.
var socialMediaSite = "Twitter"
if let site = socialMediaSite as? String {
	print("The site is \(site)")
}
// false, typecasting fails so nothing is printed

// 8.
class CitrusFruit {
	var averagePH = 3.0
}
class Orange: CitrusFruit { }
let citrus = Orange()
if let orange = citrus as? Orange {
	print("This orange has a pH of \(orange.averagePH).")
}
// true, Orange inherits from CitrusFruit & its properties, hence typecasting as Orange allows printing out the property value

// 9.
class Glasses {
	var isShortSighted = true
}
struct Sunglasses: Glasses { }
if shades = Sunglasses()
if let glasses = shades as? Glasses {
	if glasses.isShortSighted {
		print("These sunglasses are for shortsighted people.")
	} else {
		print("These sunglasses are for longsighted people.")
	}
}
// false, as fancy as the code might be, a struct cannot use class inheritance -> typecasting is of no use & nothing is printed

// 10.
class Bird {
	var wingspan: Double? = nil
}
class Eagle: Bird { }
let bird = Eagle()
if let eagle = bird as? Eagle {
	if let wingspan = eagle.wingspan {
		print("The wingspan is \(wingspan).")
	} else {
		print("This bird has an unknown wingspan.")
	}
}
// true, this code prints some output: the one from else code
// "bird" is an Eagle object, also a Bird object due to class inheritance -> has access to property "wingspan"
// if let eagle = bird as? Eagle therefore is also true
// but if let wingspan = eagle.wingspan isn’t true, as wingspan was defined as an optional Double with value nil
// so the else code got executed

// 11.
class Reading {
	var value = 0.0
}
class TemperatureReading: Reading { }
let temperature = TemperatureReading()
if let reading = temperature as? Reading {
	print("The reading is \(reading.value).")
}
// true, this prints the string
// class inheritance done right -> "tempeture" is object of both classes -> typecast reading as Reading object succeeded -> conditional of "if let" code is true -> the print statement executes

// 12.
class Sport { }
class Swimming: Sport {
	var distance = 100
}
let swimming = Sport()
if let sport as? Swimming {
	print("The distance is \(sport.distance).")
}
// false, this code doesn’t print out anything
// several problems: "sport" is undefined, should be "sport = swimming"
// also let swimming = Sport() is incorrect, class inheritance doesn’t work that way
// even if sport is defined as suggested, it still doesn’t have access to property "distance" unless "swimming" is set as a Swimming object, not Sport
