// 6. Nil coalescing
// More code examples from mini test questions & explanations
// Question: These codes demo using nil coalescing with optionals - T/F?

// 1.
let painter: String = "Leonardo da Vinci"
let artist: String = painter ?? "Unknown"
// false, because painter was defined as regular String, not String?

// 2.
var bestPony: String? = "Pinkie Pie"
let selectedPony: String? == bestPony ?? nil
// false, because of the "==" rather than "="
// selectedPony as String? is ok tho, since it can be assigned with a nil

// 3.
let lightsaverColor: String? = "green"
let color = lighsaberColor ?? "blue"
// true, this code is valid & demo nil coalescing with optionals

// 4.
var captain: String? = "Kathryn Janeway"
let name = captain ?? "Anonymous"
// true, this code is valid & demo nil coalescing with optionals

// 5.
let numberSum: Double? = 0.0
let sum: Double = numberSum ??
// false, the code is incomplete & not demoing correctly
// missing the right side of nil coalescing operator
// should’ve return a default Double value for sum

// 6.
var conferenceName: String? = "WWDC"
var conference: String = conferenceName ?? nil
// false, the code is invalid
// if intending to define conference as a regular String, then right-hand side of nil coalescing operator MUST NOT be nil
// otherwise if intending to assign nil to conference, it MUST be defined as an optional String?

// 7.
let planetNumber: Int? = 426
var destination = planetNumber ?? 3
// true, this code is valid & demo nil coalescing with optionals

// 8.
let userID: Int? = 556
let id = userID ?? "Unknown"
// false, this code is invalid
// id is being implicitly defined as an Int/Int?
// thus attempting to place a default string to it is wrong

// 9.
let distanceRan: Double? = 0.5
let distance: Double = distanceRan ?? 0
// true, this code is valid & demo nil coalescing with optionals

// 10.
var userOptedIn: Bool? = nil
var optedIn = userOptedIn ?? false
// true, this code is valid & demo nil coalescing with optionals

// 11.
let jeansNumer: Int? = nil
let jeans = jeanNumber ? 501
// false, the nil coalescing operator is "??" not "?"

// 12.
var selectedYear: Int? = nil
let actualYear = selectedYear ?? 1989
// true, this code is valid & demo nil coalescing with optionals
