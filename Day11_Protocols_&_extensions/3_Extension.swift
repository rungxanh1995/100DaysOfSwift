// 3. Extensions
// Allow adding methods to existing types
// Making them do things they weren’t origninally designed to do
// Note: Swift doesn’t allow adding stored properties in extensions
// Must be computed properties instead

// Sample code from Paul Hudson
// Add an extension to Int type for a square() method
extension Int {
	func squared() -> Int {
		return self * self
	}
}
// Add an extension to Int type for an isEven() method
extension Int {
	func isEven() -> Bool {
		return self % 2 == 0
	}
}
// Try out with an integer
let number = 8
number.squared()
// this returns 64
number.isEven()
// this returns true