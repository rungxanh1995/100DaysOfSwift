// 5. Copying class objects
// This is the 3rd diff between class and struct
// When objects of a struct are copied, they are different from each other
// While objects of a class get their values pointing to the same thing, so changing one DOES change the other
// Using a class rather than a struct sends a strong message that you want the data to be shared somehow, rather than having lots of distinct copies

// Sample code from Paul Hudson
class Singer {
	var name = "Taylor Swift"
}
var singer = Singer()
print(singer.name)
// this prints "Taylor Swift"

// Create a 2nd var from the 1st one and change its name property
var singerCopy = singer
singerCopy.name = "Justin Bieber"

// Check name of 1st variable
print(singer.name)
// this now prints out "Justin Bieber" instead of the initial value

// If Singer was a struct we’d get "Taylor Swift" printed out


////////////////////////////////////////////////////////////////
// Personal code and notes
struct DJ {
	var name = "Afrojack"
}
// I’ll try declaring a const this time
let myDJ = DJ()
print(myDJ.name)
// this prints "Afrojack"

// Now let’s create a var from the const so that I can try changing name
var myDJCopy = myDJ
myDJCopy.name = "Chico Rose"

// Double check the name property of myDJ to see whether it’d change, despite it being a constant from the first place
print(myDJ.name)
// but yeah, this now prints "Chico Rose", which means no matter how the object is a var or const, as long as it’s an instance from a class, changing values of the properties of 1 object DOES change those of the others

// Say now I create yet another var from one of the objects above
var myOtherDJ = myDJCopy
myOtherDJ.name = "David Guetta"

print(myDJ.name)
// this now prints "David Guetta" 👻
