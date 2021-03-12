// 1. Create your own struct

// Sample code from Paul Hudson
struct Sport {
	var name: String
}
var tennis = Sport(name: "Tennis")
print(tennis.name)

/////////////////////////////////////////////////////
// Personal code and notes
// Define a struct with different vars
struct iDevice {
	var deviceModel: String
	var screenSize: Float
	var deviceWeight: Int
	var hasFaceID: Bool
}
// Define a var using the struct
var iPhone11 = iDevice(deviceModel: "iPhone 11", screenSize: 6.1, deviceWeight: 194, hasFaceID: true)
// Can use vars from struct for string interpolation just fine
print("""
My iDevice is the \(iPhone11.deviceModel).
It has a \(iPhone11.screenSize) in. screen.
It is quite hefty, at \(iPhone11.deviceWeight)g.
But I really enjoy its Face ID, it’s a \(iPhone11.hasFaceID) story.
""")

// Output from console
// My iDevice is the iPhone 11.
// It has a 6.1 in. screen.
// It is quite hefty, at 194g.
// But I really enjoy its Face ID, it’s a true story.
