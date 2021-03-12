// 3. Property observers
// They observe and respond to changes in a property’s value
// They’re called every time that value is set, even if the value is the proprty’s current value

// 2 types of property observers: willSet & didSet
// willSet is called just before the value is stored
// didSet is called immediately after the new value is stored

// Sample code from Paul Hudson
struct Progress {
	var task: String
	var amount: Int {
		didSet {
			print("\(task) is now \(amount)% complete")
		}
	}
}
var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100


////////////////////////////////////////////////////////////////
// Personal code and notes
struct fileProgress {
	var taskName: String {
		// willSet observer tracks value change of var taskName
		willSet {
      // Print initializing statement before taskCompletion = 0
      if taskCompletion == 0 {
      	print("Initializing \(taskName).")
      }
      // Print task finalizing statement before taskCompletion = 100
      else if taskCompletion == 100 {
      	print("Finalizing \(taskName).")
      }
    }
		// didSet observer tracks value change of var taskName
		didSet {
			print("\(taskCompletion)% \(taskName).")
		}
	}
	var taskCompletion: Int {
		// didSet observer tracks value change of taskCompletion
		didSet {
			print("Current progress: \(taskCompletion)%...")
		}
	}
}
// Define output var with initialized values
var loadFile = fileProgress(taskName: "loading file", taskCompletion: 0)
loadFile.taskName = "file loading"
loadFile.taskCompletion = 30
// Change current value with same value, didSet still got triggered
loadFile.taskCompletion = 30
loadFile.taskCompletion = 80
loadFile.taskCompletion = 100
loadFile.taskName = "file loaded"

// Output in console
// Initializing loading file.
// 0% file loading.
// Current progress: 30%...
// Current progress: 30%...
// Current progress: 80%...
// Current progress: 100%...
// Finalizing file loading.
// 100% file loaded.
