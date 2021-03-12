// 5. Implicitly unwrapped optionals (IUOs)

// Regular optionals uses "?", IUOs uses "!"
// IUOs also either contain a value or be nil
// You can use them as if they weren’t optionals at all
let age: Int! = nil

// As they behave as if already unwrapped
// We don’t need if let or guard let
// But if their value is nil and we use them, our code crashes!

// However, just use regular optionals if possible
// Good case of using IUOs is when a var starts up "nil" at first, but by the time they’re used as IUOs they’re already DEFINITELY filled with values. And it’s annoying to just unwrapping them everytime like we do regular optionals when we’re sure they’re NOT nil
