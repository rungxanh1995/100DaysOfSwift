//
//  Storyboarded.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-24.
//

import UIKit

protocol Storyboarded {
	static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
	static func instantiate() -> Self {
		let id = String(describing: self)
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		return storyboard.instantiateViewController(withIdentifier: id) as! Self
	}
}
