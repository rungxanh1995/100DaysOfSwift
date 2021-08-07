import UIKit


// challenge 1
extension UIView {
	
	/**
	Uses animation to scale a view's size down to 0.0001 over a specified number of seconds.
	- parameters:
		- duration: The number of seconds for animation.
	*/
	func bounceOut(duration: TimeInterval) {
		UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: []) { [weak self] in
			self?.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
		}
	}
}


// challenge 2
extension Int {
	
	/**
	Runs a closure as many times as the number is high
	- complexity:
	O(*n*), where *n* is the value of the integer.
	- parameters:
		- closure(): The closure to be executed.
	*/
	func times(_ closure: () -> Void) {
		guard self >= 0 else	{ return }
		for _ in 0..<self		{ closure() }
	}
}


// challenge 3
extension Array where Element: Comparable {
	
	/**
	Removes only the first instance it finds if the item exists more than once in an array.
	- complexity:
	O(*n*), where *n* is the length of the array.
	- parameters:
		- item: An item to look for in the array.
	*/
	mutating func remove(item: Element) {
		if let index = self.firstIndex(of: item) { self.remove(at: index) }
	}
}

