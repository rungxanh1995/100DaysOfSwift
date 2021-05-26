//
//  CountryDetailViewController.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-20.
//

import UIKit

class CountryDetailViewController: UITableViewController, Storyboarded {
	weak var coordinator: MainCoordinator?
	let countryDetailDataSource = CountryDetailDataSource()
	var country: Country {
		return countryDetailDataSource.getCountry()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = countryDetailDataSource
		tableView.delegate = self
		title = country.name
		navigationItem.largeTitleDisplayMode = .never
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .action,
			target: self,
			action: #selector(shareFacts))
	}
	
	@objc
	func shareFacts() {
		if Utils.isHapticAvailable {
			Utils.hapticFeedback(from: .button)
		}
		var shareItems = [Any]()
		if let flag = UIImage(named: Utils.getFlagFileName(code: (country.alpha2Code), type: .HD))?.pngData() {
			shareItems.append(flag)
		}
		shareItems.append(countryDetailDataSource.getSharedText())
		
		let vc = UIActivityViewController(activityItems: shareItems,
										  applicationActivities: nil)
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true)
	}
}

