// 3. Unwrapping with guard

// so you use if let to unwrap optionals and assign the value to a property
// you can also use "guard let"
// difference: the assigned property STAYS around after the "guard" code

// Sample code from Paul Hudson
// and personal code and notes

// Define a func that accepts an optional
func greet(_ name: String?) {
	// then upwrap it with guard let
	// if there’s nil inside, it prints a message an exit
	guard let unwrap = name else {
		print("This code runs if content of name is nil.")
		return
	}
	// since the unwrapped property stays around after guard code
	// we can print it out
	print("This code runs if there’s content passed into name.")
	print("The content is \(unwrapped).")
}
// to try this out, just call the func
greet(nil)
greet("hello")

// final point: using "guard let" lets you deal with issues at the start of the funcs, then exit immediately
// the rest of the code is then happy because the optional is NOT nil
// therefore, use "if let" if you just want to unwrap some optionals
// but "guard let" if you’re specifically checking that conditions are correct before continuing












