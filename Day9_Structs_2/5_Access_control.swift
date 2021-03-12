// 5. Access control
// Swift provides "private" & "public" to let you adjust the extent to which code can use properties & methods
// Consider it like privacy protection tools

// Sample code from Paul Hudson
struct Person {
	// Make id private to restrict access from outside the struct
	private var id: String
	init(id: String) {
		self.id = id
	}
	func identify() -> String {
		return "My social security number is \(id)."
		// id is still accessible within the struct, but not ouside
	}
}
let ed = Person(id: "12345")
// therefore this code won’t work
ed.id
// however, this func still reveals the id number regardless
// because it was not private (aka public)
ed.identify()


/////////////////////////////////////////////////////////////////
// Extra code examples from mini test questions & explanations
// 1.
struct FacebookUser {
	private var privatePosts: [String]
	public var publicPosts: [String]
}
let user = FacebookUser()
// this code is invalid and it has several problems, not least letting privatePosts a private property that makes Swift fail to generate its memberwise init() to grant value to privatePosts like a public one

// 2.
struct Order {
	private var id: Int
	init(id: Int) {
		self.id = id
	}
}
let order = Order(id: "1")
// this code is invalid, as init() expects an Int but given a String

// 3.
struct Person {
	private var socialSecurityNumber: String
	init(ssn: String) {
		socialSecurityNumber = ssn
	}
}
let sarah = Person(ssn: "555-55-5555")
// this code is valid

// 4.
struct Contributor {
	private var name = "Anonymous"
}
let paul = Contributor()
// this code is valid, since property "name" is defined with a value up front, not via an init() despite being private

// 4.
struct SecretAgent {
	private var actualName: String
	public var codeName: String
	init(name: String, codeName: String) {
		self.actualName = name
		self.codeName = codeName
	}
}
let bond = SecretAgent(name: "James Bond", codeName: 007)
// this code seems valid at first, but it attempts to pass in an Int for codeName when creating the instance

// 5.
struct Doctor {
	var name: String
	var location: String
	private var currentPatient = "No one"
}
let drJones = Doctor(name: "Esther Jones", location: "Bristol")
// this code is invalid with the similar reason as code 1: it lacks a custom init() to define the value of properies, not least letting currentPatient be private

// 6.
struct Office {
	private var passCode: String
	var address: String
	var employees: [String]
	init(address: String, employees: [String]) {
		self.address = address
		self.employees = employees
		self.passCode = "SEKRIT"
	}
}
let monmouthStreet = Office(address: "30 Monmouth St", employees: ["Paul Hudson"])
// this code is long, but it’s all valid

// 7.
struct RebelBase {
	private var location: String
	private var peopleCount: Int
	init(location: String, people: Int) {
		self.location = location
		self.people = peopleCount
	}
}
let base = RebelBase(location: "Yavin", people: 1000)
// this code is invalid because the syntax of init() code must be like this "self.peopleCount = people" to be correct

// 8.
struct School {
	var staffNames: [String]
	private var studentNames: [String]
	init(staff: String...) {
		self.staffNames = staff
		self.studentNames = [String]()
	}
}
let royalHigh = School(staff: "Mrs Hughes")
// this code is valid
// String... means you can add more String input to "staff"
// self.studentNames = [String]() calls the string init() to create an empty String array
// therefore royalHigh.studentNames.isEmpty would return "true"

// 9. struct Customer {
	var name: String
	private var creditCardNumber: Int
	init(name: String, creditCard: Int) {
		self.name = name
		self.creditCardNumber = creditCard
	}
}
let lottie = Customer(name: "Lottie Knights", creditCard: 1234567890)
// this code is valid

