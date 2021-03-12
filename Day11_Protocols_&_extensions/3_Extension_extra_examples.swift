// 3. Extensions
// Extra code examples from mini test question & explanations
// Question: these code are valid extensions - T/F?

// 1.
extension Double {
	var isNegative: Bool {
		return self < 0
	}
}
// true: this code is a valid extension on Double

// 2.
extension Int {
	var isEven {
		return self % 2 == 0
	}
}
// false: missing type annotation for isEven

// 3.
extension String {
	func append(_ other: String) {
		self += other
	}
}
// false: append() method should be marked mutating to return changed value of self

// 4.
extension Int {
	times(_ action: () -> Void) {
		for _ in 0..<self {
			action()
		}
	}
}
// false: missing keyword "func" for method times()

// 5.
ext Array {
	func summarize() {
		print("The array has \(count) items. They are:")
		for item in self {
			print(item)
		}
	}
}
// false: as fancy as it is, this isn’t a valid extension
// because "ext" should read "extension"

// 6.
extension Int {
	var isAnswerToLifeUniverseAndEverything: Bool {
		let target = 42
		self == target
	}
}
// false: this computed property isn’t returning anything

// 7.
extension Bool {
	func toggled() -> Bool {
		if self = true {
			return false
		} else {
			return true
		}
	}
}
// false: the comparison operator’s supposed to be "==", not "="

// 8.
extension Int {
	func cubed() -> Int {
		return self * self * self
	}
}
// true, and side note: there’s always a hidden "self" param passed into each method even tho there’s nothing in between ()

// 9.
extension Int {
	func clamped(min: Int, max: Int) -> Int {
		if (self > max) {
			return max
		} else if (self < min) {
			return min
		}
		return self
	}
}
// true, it’s a valid extension to Int

// 10.
extension String {
	var isLong: Bool {
		return count > 25
	}
}
// true, this returns true if the built-in "count" property is greater than 25

// 11.
extension String {
	func withPrefix(_ prefix: String) -> String {
		if self.hasPrefix(prefix) { return self }
		return "\(prefix)\(self)"
	}
}
// true, it’s a valid extension to String

// 12.
extension String {
	func isUppercased() -> Bool {
		return self == self.uppercased()
	}
}
// true, this returns true if self == self.uppercased()
