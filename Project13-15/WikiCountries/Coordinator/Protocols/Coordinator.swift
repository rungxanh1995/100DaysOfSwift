//
//  Coordinator.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-24.
//

import UIKit

protocol Coordinator {
	var children: [Coordinator] { get set }
	var navigationController: UINavigationController { get set }
	
	func start()
}
