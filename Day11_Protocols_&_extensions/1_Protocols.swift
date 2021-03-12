protocol Identifiable {
  // This reads id as a String can be read (get) and written (set)
  var id: String {get set}
  var age: Int {get}
}
// Protocols define how structs, classes, enums out to work
// What methods they should have
// What properties they should have
// Swift makes sure they have all the methods & properties required by that protocol

// We can't create instances of a protocol
// It's rather a description of what we want than smth we can create and use directly

// But we CAN create some kind of data that adopts (aka conforms to) it
// This reads struct User conforms to Identifiable
struct User: Identifiable {
  var id: String
  var age: Int
}
func displayID(thing: Identifiable) {
  print("My ID is \(thing.id).")
  print("I'm \(thing.age) years old.")
}

