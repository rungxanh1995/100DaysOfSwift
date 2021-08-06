import UIKit


extension String {
	
	// challenge 1
	/**
	Adds a given prefix to a string.
	If the string already contains the prefix it should return itself;
	if it doesn’t contain the prefix, it should return itself with the prefix added.
	
	- parameters:
		- prefixString: The prefix of type `String` to attach
	*/
	func withPrefix(_ prefixString: String) -> String {
		if self.prefix(prefixString.count) == prefixString { return self }
		return prefixString + self
	}
	
	
	// challenge 2
	/**
	Returns true if a string holds any sort of number.
	*/
	var isNumeric: Bool {
		return Double(self) != nil ? true : false
	}
	
	
	// challenge 3
	/**
	Returns an array of all the lines in a string.
	*/
	var lines: [String] {
		return self.components(separatedBy: "\n")
	}
}


// MARK: Test cases
let input = "this\nis\na\ntest"
input.withPrefix("car")
input.isNumeric
input.lines
