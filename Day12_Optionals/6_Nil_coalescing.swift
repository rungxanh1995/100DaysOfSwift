// 6. Nil coalescing & nil coalescing operator "??"

// This is when the "??" operator unwraps an optional
// then returns a value if there’s one inside the optional
// otherwise a pre-set value if it’s nil

// Let’s try a func that returns an optional String
func username(for id: Int) -> String {
	if id == 1 {
		// Return a value to optional String
		return "User 1"
	} else {
		// Return nil to optional String
		return nil
	}
}
// Deliberately pass a value to param to return a nil String
// Use nil coalescing operator to return a default value instead of nil
let user = username(for: 15) ?? "Anonymous user"

// Again, what nil coalescing operator does here?
// 1st it checks the result that comes back from username()
// if it’s a string -> unwrapped -> placed into "user"
// if it’s nil -> "Anonymous user" is used instead
// Either way, the optional always has a non-nil value
