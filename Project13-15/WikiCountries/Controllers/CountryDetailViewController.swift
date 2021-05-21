//
//  CountryDetailViewController.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-20.
//

import UIKit

class CountryDetailViewController: UITableViewController {
	var country: Country!
	
	enum Section: String {
		case flag = "Flag"
		case general = "General"
		case languages = "Languages"
		case currencies = "Currencies"
	}
	let sectionTitles: [Section] = [.flag, .general, .languages, .currencies]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		guard country != nil else { return }
		title = country.name
		navigationItem.largeTitleDisplayMode = .never
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .action,
			target: self,
			action: #selector(shareFacts))
	}
}

