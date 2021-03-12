// 5. Mutating methods
// Personal notes
// Struct in Swift doesn’t allow changing value of its properties by default
// Unless you specifically request it; otherwise the struct treats its properties as constants regardless of how they’re declared (var or let)
// In which case you have to use the keyword "mutating" before the func that would change the properties’ values.

// Sample code from Paul Hudson
struct Person {
	var name: String
	mutating func makeAnonymous() {
		name = "Anonymous"
	}
}
var person = Person(name: "Ed")
person.makeAnonymous

// Extra sample codes from mini-test questions
// 1.
struct Diary {
  var entries: String
  mutating func add(entry: String) {
    entries += "\(entry)"
    print(entries)
  }
}
var myDiary = Diary(entries: "Start of Diary\n")
myDiary.add(entry: "Hello")

// 2.
struct Surgeon {
	var operationsPerformed = 0
	mutating func operate(on patient: String) {
		print("Nurse, hand me the scalpel!")
		operationsPerformed += 1
	}
}

// 3.
struct Stapler {
	var stapleCount: Int
	mutating func staple() {
		if stapleCount > 0 {
			stapleCount -= 1
			print("It’s stapled!")
		} else {
			print("Please refill me.")
		}
	}
}

// 4.
struct Tree {
	var height: Double
	mutating func grow() {
		height *= 1.001
	}
}
// Create an object of Tree and call the method
var myTree = Tree(height: 0.5)
myTree.grow()
print(myTree.height)

// 5.
struct Car {
	var mileage: Int
	mutating func drive(distance: Int) {
		mileage += distance
	}
}

// 6.
// This sample code seems logically incorrect though
struct Book {
	var totalPages: Int
	var pagesLeftToRead = 0
	mutating func read(pages: Int) {
		// This is where it goes haywire with the logic 🔽
		if pages < pagesLeftToRead {
			pagesLeftToRead -= pages
		} else {
			pagesLeftToRead = 0
			print("I'm done!")
		}
	}
}

// Personal approach on the code
struct Book {
  var totalPages: Int
  var pagesLeftToRead = 0
  mutating func read(pages: Int) {
  	// This is my logic on that
    if pages < totalPages {
      pagesLeftToRead = totalPages - pages
    } else {
      pagesLeftToRead = 0
      print("I'm done!")
    }
  }
}
var myBook = Book(totalPages: 100)
myBook.read(pages: 15)
print(myBook.pagesLeftToRead)

// 7.
struct Delorean {
	var speed = 0
	mutating func accelerate() {
		speed += 1
		if speed == 88 {
			travelThroughTime()
		}
	}
	func travelThroughTime() {
		print("Where we’re going we don’t need roads.")
	}
}

// 8.
struct Bicycle {
	var currentGear: Int
	mutating func changeGear(to newGear: Int) {
		currentGear = newGear
		print("I’m now in gear \(currentGear).")
	}
}

// 9.
struct BankAccount {
	var balance: Int
	mutating func donate(amount: Int) {
		balance -= amount
	}
}