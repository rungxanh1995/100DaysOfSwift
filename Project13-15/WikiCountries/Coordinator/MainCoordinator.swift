//
//  MainCoordinator.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-24.
//

import UIKit

class MainCoordinator: Coordinator {
	var children = [Coordinator]()
	
	var navigationController: UINavigationController
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let vc = CountryListViewController.instantiate()
		vc.coordinator = self
		vc.showCountryAction = show(_:)
		navigationController.pushViewController(vc, animated: false)
	}
	
	func show(_ country: Country) {
		let detailVC = CountryDetailViewController.instantiate()
		detailVC.coordinator = self
		detailVC.countryDetailDataSource.country = country
		navigationController.pushViewController(detailVC, animated: true)
	}	
}
