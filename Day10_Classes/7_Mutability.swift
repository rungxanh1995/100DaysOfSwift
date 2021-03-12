// 7. Mutability in a Class
// In contrast to structs, variable properties of a class can be changed
// That’s why classes don’t need keyword "mutating" with methods that change properties
// Therefore, to NOT change the value of a class property, you define it as a constant with "let" instead of "var"

// Sample code from Paul Hudson
class Singer {
	var name = "Taylor Swift"
}
let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
// this code is totally valid, just like in the past readings

// So to prevent "name" from changing, you define it like this
class Singer {
	let name = "Taylor Swift"
}