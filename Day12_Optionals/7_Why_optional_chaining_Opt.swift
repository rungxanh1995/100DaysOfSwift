// 7. Optional chaining (Opt read): Why is optional chaining important?

// As a concept, optional chaining let’s us dig thru several layers of optionals in a single line of code
// If any of the layers is nil, then the entire line is nil

// We can couple optional chaining w/ nil coalescing to provide a sensible fallback if any of the optionals are nil

// Code from Paul Hudson to demo
// Define a dict w first name as key & last name as value
let names = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
// Plain optional chain would return nil if any optional is nil
let surnameLetter = names["Vincent"]?.first?.uppercased()
// this returns the uppercased "V" in "van Gogh"
// Let’s try one that’s not in the dict
let johnSurnameLetter = names["John"]?.last?.uppercased()
// this returns nil because names["John"]? is already nil

// Using nil coalescing to provide a default fallback value
let janeSurnameLetter = names["Jane"]?.first?.uppercased() ?? "?"
// this returns a "?" string
