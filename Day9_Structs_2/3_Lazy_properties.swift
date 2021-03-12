// 3. Lazy properties
// Swift allows some properties to be created when they’re needed
// Say we define a struct FamilyTree
struct FamilyTree {
	var name: String
	init(name: String) {
		print("Creating family tree!")
	}
}
// Now define a struct Person
// and a var as an object of struct FamilyTree above
struct Person {
	var name: String
	// but somehow we don’t want this person to get a family tree
	// so we put "lazy" in front
	// to make Swift ONLY create his family tree when explicitly called
	lazy var familyTree = FamilyTree()
	init(name: String) {
		self.name = name
	}
}
var ed = Person(name: "Ed")
// not until we call the code below that Ed be created a family tree
ed.familyTree



///////////////////////////////////////////////////////////////////
// Personal code and more notes
// Say I want the FamilyTree struct init() to print Joe name too
// In other words I want to say the name "Joe" just once
// It’d be coded like this
struct FamilyTree {
	var name: String
	init(name: String) {
		// self.name refers to var "name" is this struct, not param "name" of init()
		self.name = name
		print("Creating family tree for \(name)...")
	}
}
struct Person {
	var name: String
	lazy var familyTree = FamilyTree(name: name)
	// left "name" is property of struct FamilyTree
	// whereas right "name" is value of property "name" of struct Person
	init(name: String) {
		self.name = name
	}
}
var joe = Person(name: "Joe")
joe.familyTree()
// 1. so string "Joe" will be passed in var "joe", as defined by init() of struct Person
// 2. then this init() assigns "Joe" to property "name" of struct Person
// 3. then property "familyTree", as an object of struct FamilyTree, get passed in with "Joe" to its property (name: )
// 4. and since init() of struct FamilyTree requires a var to be taken in, "Joe" continues to be passed into that var "name"
// 5. finally, "Joe" got passed to property "name" of struct FamilyTree via self.name = name
// This same property/var name is absolutely terrible for code readability
// But it shows how data travels