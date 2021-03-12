// 4. When should you force unwrapp optionals in Swift

// Let’s start with an example using enum that conforms to built-in CaseIterable protocol
enum Direction: CaseIterable {
	case north, south, east, west
}
// CaseIterable includes an "allCases" array property for the enum
// It ontains all the cases in the order they were defined
let randomDirection = Direction.allCases.randomElement()!
// This first returns an optional to randomDirection as that’s how randomElement() works
// But you know the enum always has cases
// Therefore force unwrapping here is "safe"

// Moreover, you can also prevent your code littered with force unwrapping by creating funcs/extensions that isolate your force unwraps in 1 place
// Then the remaining of your code doesn’t need force unwrap directly
// So we rewrite the Direction enum like this
enum Direction: CaseIterable {
	case north, south, east, west
	// force unwrap right in here with a static method
  // to prevent littering the code with force unwraps
	static func random() -> Direction {
		Direction.allCases.randomElement()!
	}
}
let randomDirection = Direction.random()
// Here you don’t need force unwrapping anymore

// Some other examples where force unwrapping is safe

// It’s safe here because the Int range was typed in
let randomNumber = (1...10).randomElement()!

// It’s safe here because the URL was typed in, not thru string interpolation
let url = URL(string: "https://www.apple.com")
