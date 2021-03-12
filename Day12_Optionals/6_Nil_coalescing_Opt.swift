// 6. When should you use nil coalescing?

// Best thing gained from nil coalescing: grants the optional a default value rather than leaving it nil; 'cause it’s usually safer to have regular data instead of a nil

// For example, in a chat app to load a message draft
let savedData = loadSavedMessage() ?? ""
// If loadSavedMessage() returns a string optional, it’d be unwrapped & assigned to savedData
// If it returns a nil then Swift assigns an empty string in there
// Either way you get savedData being a String, not a String?
// You also can chain nil coalescing
// to make Swift try it out like waterfall
let savedData = first() ?? second() ?? ""
// This runs first() -> if returns nil then runs second() -> if still nil then returns an empty string

// A special case: reading dictionary ALWAYS returns an optional
// Thus using nil coalescing to get back a non-optional
let scores = ["Picard": 800, "Data": 7000, "Troi": 900]
let crusherScore1 = scores["Data"]
print(crusherScore1)
// this prints "Optional(7000)"
let crusherScore2 = score["Crusher"]
print(crusherScore2)
// this prints an implicitly coerced nil
// But nil coalescing gives it a default value
let crusherScore3 = scores["Crusher"] ?? 0
// Another syntax with dicts is
let crusherScore4 = scores["Crusher", default: 0]
// this returns the same output as the code above
