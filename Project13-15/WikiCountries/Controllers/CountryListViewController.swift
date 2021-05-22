//
//  ViewController.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-19.
//

import UIKit

class CountryListViewController: UITableViewController {

	private var countryListDataSource = CountryListDataSource()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = countryListDataSource
		tableView.delegate = self
		tableView.rowHeight = 68
		title = "WikiCountries"
		navigationController?.navigationBar.prefersLargeTitles = true
		DispatchQueue.global().async {
			self.countryListDataSource.loadData()
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}
}

extension CountryListViewController {
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		Utils.hapticFeedback(from: .cell)
		let storyboard = UIStoryboard(name: Utils.mainStoryboardName, bundle: nil)
		let vc = storyboard.instantiateViewController(identifier: Utils.detailStoryboardIdentifier) as CountryDetailViewController
		// pass the selected country to the
		// detail view controller's data source
		vc.countryDetailDataSource.country = countryListDataSource.country(at: indexPath.row)
		navigationController?.pushViewController(vc, animated: true)
	}
}
