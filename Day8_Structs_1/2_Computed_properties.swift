// 2. Computer properties

// Sample code from Paul Hudson
struct Sport {
	var name: String
	var isOlympicSport: Bool
	
	var olympicStatus: String {
		if isOlympicSport {
			return "\(name) is an Olympic sport."
		} else {
			return "\(name) is not an Olympic sport."
		}
	}
}

let chessBoxing = Sport(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

//////////////////////////////////////////////////////////////
// Personal code and notes
// Variables in a struct is referred to as "properties"
// A property that is computed (or returned) is called a computed property
// A computed property gets recomputed each time it’s called
struct iPhone {
	var iPhoneModel: String
	// A computed property MUST always have an explicit dataType
	var hasFaceID: Bool {
		// hasFaceID value is computed, not by fed in
		switch iPhoneModel {
			case "iPhone X", "iPhone Xs", "iPhone Xs Max", "iPhone 11", "iPhone 11 Pro", "iPhone 11 Pro Max", "iPhone 12 mini", "iPhone 12", "ihone 12 Pro", "iPhone 12 Pro Max":
				return true
			default:
				return false
		}
	}
}
let myiPhone = iPhone(iPhoneModel: "iPhone 11")
print("It is \(myiPhone.hasFaceID) that my iPhone has Face ID.")