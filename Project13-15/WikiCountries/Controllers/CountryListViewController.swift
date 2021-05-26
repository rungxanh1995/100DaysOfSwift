//
//  ViewController.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-19.
//

import UIKit

class CountryListViewController: UITableViewController, Storyboarded {
	weak var coordinator: MainCoordinator?
	private var countryListDataSource = CountryListDataSource()
	
	typealias ShowCountryAction = (Country) -> Void
	var showCountryAction: ShowCountryAction?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = countryListDataSource
		tableView.delegate = self
		tableView.rowHeight = 68
		title = "WikiCountries"
		navigationController?.navigationBar.prefersLargeTitles = true
		DispatchQueue.global().async { [weak self] in
			self?.countryListDataSource.countries = Bundle.main.decode(from: Utils.jsonSourceURL)
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
	}
}

extension CountryListViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if Utils.isHapticAvailable {
			Utils.hapticFeedback(from: .cell)
		}
		let country = countryListDataSource.country(at: indexPath.row)
		showCountryAction?(country)
	}
}
