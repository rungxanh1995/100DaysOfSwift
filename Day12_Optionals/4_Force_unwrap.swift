// 4. Force unwrapping with "!"
// Sometimes you know FOR SURE that a value isn’t nil
// And it can be used CORRECTLY
// Swift allows force unwrapping the optional with "!"
// Convert it from an optional type to a non-optional

// For example, if you have a string that contains a number
// You can convert it to an Int
let string = "5"
let num = Int(string)
// this makes "num" an optional Int
// as string could’ve also been other characters like "fish"
// in fact, printing out num like this
print(num)
// will return "Optional(5)" & warning: Expression implicitly coerced from "Int?" to "Any"

// Tho Swift isn’t sure the conversion will work
// You certainly see the code is "safe"
// So you can force unwrap the result like this
let num = Int(string)!

// => Swift immediately unwrap the optional & make num a regular Int
print(num)
// this prints the integer 5

// But if you’re wrong, your code CRASH!
// Therefore use this method with caution
// It’s also called the crash operator
