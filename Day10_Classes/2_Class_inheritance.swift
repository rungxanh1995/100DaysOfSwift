// 2. Class inheritance

// Sample code from Paul Hudson
class Dog {
	var name: String
	var breed: String
	init(name: String, breed: String) {
		self.name = name
		self.breed = breed
	}
}
// A subclass would inherit the same properties & init as parent class by default
class Poodle: Dog {
	// Can also give Poodle its own init()
	init(name: String) {
		super.init(name: name, breed: "Chihuahua")
		// left "name" refers to property "name" in class Dog
		// right "name" refers to value of param "name" of init() of class Chihuahua
		// same with "breed"
	}
}

////////////////////////////////////////////////////////////////
// Extra code samples from mini test questions & explanations
// Question: these code demo valid class inheritance - T/F?
// 1.
class Vehicle {
	var wheels: Int
	init(wheels: Int) {
		self.wheels = wheels
	}
}
class Truck: Vehicle {
	var goodsCapacity: Int
	init(wheels: Int, goodsCapacity: Int) {
		self.goodsCapacity = goodsCapacity
		super.init()
	}
}
// this code is invalid for class inheritance
// missing argument for "wheels" in super.init()
// should’ve been super.init(wheels: wheels)

// 2.
class Student {
	var name: String
}
class UniversityStudent: Student {
	var annualFees: Int
	init(name: String, annualFees: Int) {
		self.annualFees = annualFees
		super.init(name: name)
	}
}
// this code is invalid
// class Student missing its own init()

// 3.
class Handbag {
	var price: Int
	init(price: Int) {
		self.price = price
	}
}
class DesignerHandbag: Handbag {
	var brand: String
	init(brand: String, price: Int) {
		self.brand = brand
		super.init(price: price)
	}
}
// this code is valid in demoing a class inheritance

// 4.
class Product {
	var name: String
	init(name: String) {
		self.name = name
	}
}
class Book: Product {
	var isbn: String
	init(name: String, isbn: String) {
		self.isbn = isbn
		super.init(name: name)
	}
}
// this code is valid in demoing a class inheritance

// 5.
class Computer {
	var cpu: String
	var ramGB: Int
	init(cpu: String, ramGB: Int) {
		cpu = cpu
		ramGB = ramGB
	}
}
class Laptop: Computer {
	var screenInches: Int
	init(screenInches: Int, cpu: String, ramGB: Int) {
		self.screenInches = screenInches
		super.init(cpu: cpu, ramGB: ramGB)
	}
}
// this code is invalid
// missing "self"s in init() of class Computer

// 6.
class Bicycle {
	var color: String
	init(color: String) {
		self.color = color
	}
}
class MountainBike: Bicycle {
	var tireThickness: Double
	init(color: String, tireThickness: Double) {
		self.tireThickness = tireThickness
		super.init(color: color)
	}
}
// this code is valid in demoing a class inheritance

// 7.
class SmartPhone {
	var price: Int
	init(price: Int) {
		self.price = price
	}
}
class SmartPhone: SmartPhone {
	var features: [String]
	init(features: [String]) {
		self.features = features
		super.init(price: features.count * 50)
	}
}
// this code is invalid
// it attempts to inherit a class from itself

// 8.
class Dog {
	var breed: String
	var isPedigree: Bool
	init(breed: String, isPedigree: Bool) {
		self.breed = breed
		self.isPedigree = isPedigree
	}
}
class Poodle {
	var name: String
	init(name: String) {
		self.name = name
		super.init(breed: "Poodle", isPedigree: true)
	}
}
// this code is invalid
// missing inheritance to class Poodle from class Dog

// 9.
class Instrument {
	var name: String
	init(name: String) {
		self.name = name
	}
}
class Piano: Instrument {
	var isElectric: Bool
	init(isElectric: Bool) {
		self.isElectric = isElectric
		super.init(name: "Piano")
	}
}
// this code is valid in demoing a class inheritance

// 10.
class Printer {
	var cost: Int
	init(cost: Int) {
		self.cost = cost
	}
}
class LaserPrinter: Printer {
	var model: String
	init(model: String, cost: Int) {
		self.model = model
		super.init(cost: cost)
	}
}
// this code is valid in demoing a class inheritance

// 11.
class Food {
	var name: String
	var nutritionRating: Int
	super init(name: String, nutritionRating: Int) {
		self.name = name
		self.nutritionRating = nutritionRating
	}
}
class Pizza: Food {
	init() {
		super.init(name: "Pizza", nutritionRating: 3)
	}
}
// this code is invalid
// super init as 2 keywords are not allowed
// not least the parent class Food has none of its parent class to inherit anything from

// 12.
class Shape {
	var sides: Int
	init(sides: Int) {
		self.sides = sides
	}
}
class Rectangle : Shape {
	var color: String
	init(color: String) {
		self.color = color
		super.init(sides: 4)
	}
}
// this code is valid in demoing a class inheritance