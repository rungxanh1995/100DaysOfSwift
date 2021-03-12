// 5. Copying objects
// Extra code examples from mini test questions & explanations
// Question: these codes print the same output twice - T/F?

// 1.
struct GalaticaCrew {
	var isCyclon = false
}
var starbuck = GalaticaCrew()
var tyrol = starbuck
tyrol.isCyclon = true
print(starbuck.isCyclon)
print(tyrol.isCyclon)
// false, because these are objects of a struct
// so their values are unique

// 2.
class Statue {
	var sculptor = "Unknown"
}
var venusDeMilo = Statue()
venusDeMilo.sculptor = "Alexandros of Antioch"
var david = Statue()
david.sculptor = "Mechaelangelo"
print(venusDeMilo.sculptor)
print(david.sculptor)
// false, because these objects were created from definition of the class, not by copying from one another

// 3.
class Starship {
	var maxWarp = 9.0
}
var voyager = Starship()
voyager.maxWarp = 9.975
var enterprise = voyager
enterprise.maxWarp = 9.6
print(voyager.maxWarp)
print(enterprise.maxWarp)
// true, because enterprise was copied from voyager
// and they’re objects of a class

// 4.
struct Calculator {
	var currentTotal = 0
}
var baseModel = Calculator()
var casio = baseModel
var texas = baseModel
casio.currentTotal = 556
texas.currentTotal = 384
print(casio.currentTotal)
print(texas.currentTotal)
// false, as these instances were created from a struct

// 5.
class Author {
	var name = "Anonymous"
}
var dickens = Author()
dickens.name = "Charles Dickens"
var austen = dickens
austen.name = "Jane Austen"
print(dickens.name)
print(austen.name)
// true, as austen was copied from dickens
// they’re both objects of a class

// 6.
class Hater {
	var isHating = true
}
var hater1 = Hater()
var hater2 = hater1
hater1.isHating = false
print(hater1.isHating)
print()hater2.isHating)
// true, as hater2 was copied from hater1
// they’re both objects of a class

// 7.
class Hospital {
	var onCallStaff = [String]()
}
var londonCentral = Hospital()
var londonWest = londonCentral
londonCentral.onCallStaff.append("Dr Harlan")
londonWest.onCallStaff.append("Dr Haskins")
print(londonCentral.onCallStaff.count)
print(londonWest.onCallStaff.count)
// true, they both print out 2
// because londonWest was copied from londonCentral
// and they’re both objects of a class

// 8.
class Ewok {
	var fluffinessPercentage = 100
}
var chirpa = Ewok()
var wicket = Ewok()
chirpa.fluffinessPercentage = 90
print(wicket.fluffiPercentage)
print(chirpa.fluffinessPercentage)
// false, as the objects were created from definition of the class
// not by being copied from one another

// 9.
class Queen {
	var isMotherOfDragons = false
}
var elizabeth = Queen()
var daenerys = Queen()
daenerys.isMotherOfDragons = true
print(elizabeth.isMotherOfDragons)
print(daenerys.isMotherOfDragons)
// false, with same reason like code 8 above

// 10.
class BasketballPlayer {
	var height = 200.0
}
var lebron = BasketballPlayer()
lebron.height = 203.0
var curry = BasketballPlayer()
curry.height = 190
print(lebron.height)
print(curry.height)
// false, they’re separate class instances, not created from one another

// 11.
class Magazine {
	var pageCount = 132
}
var example = Magazine()
var wired = example
wire.pageCount = 164
var vogue = example
vogue.pageCount = 128
print(wired.pageCount)
print(vogue.pageCount)
// true, wired & vogue were copied from another instance of the class

// 12.
class Hairdresser {
	var clients = [String]()
}
var tim = Hairdresser()
tim.clients.append("Jess")
var dave = tim
dave.clients.append("Sam")
print(tim.clients.count)
print(dave.clients.count)
// true, they both print out 2
// as dave was created as a copy of tim, so changing its value changes the other’s
