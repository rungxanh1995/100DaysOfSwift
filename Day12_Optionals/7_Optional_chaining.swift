// 7. Optional chaining

// The concept is about using a shortcut when using optionals
// Eg: you want to access smth using a.b.c when b is an optional
// then you code a "?" right after b
// if b is nil, then c is ignore
// if b has a value, then c is executed

// Sample code from Paul Hudson
// Define a String array with values
let names = ["John", "Paul", "George", "Ringo"]
// Use property "first" of the array to return the 1st item
// Then call method uppercased() to return an uppercased string
let beatle = names.first?.uppercased()
// This checks the 1st value of the array & see it’s not nil
// therefore uppercased() was run

// Now let’s try an empty array
let emptyNames = [String]()
let name = emptyNames.first?.uppercased()
// As emptyNames is empty, it’s "first" property = nil
// Optional chaining checks "first" & see it’s being nil
// So it ignores uppercased() & const "name" is still being nil
