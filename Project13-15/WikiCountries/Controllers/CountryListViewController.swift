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
	
	let searchController = UISearchController(searchResultsController: nil)
	private var isSearchBarEmpty: Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}
	private var isFiltering: Bool {
		return searchController.isActive && !isSearchBarEmpty
	}
	
	fileprivate func configureSearchController() {
		searchController.searchResultsUpdater = self
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder = "Search Countries, Capitals, Demonyms"
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = countryListDataSource
		tableView.delegate = self
		tableView.rowHeight = 68
		title = "WikiCountries"
		navigationController?.navigationBar.prefersLargeTitles = true
		configureSearchController()
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

extension CountryListViewController: UISearchResultsUpdating {
	internal func updateSearchResults(for searchController: UISearchController) {
		let searchBar = searchController.searchBar
		filterContentForSearchText(searchBar.text!)
	}
}

extension CountryListViewController {
	fileprivate func filterContentForSearchText(_ searchText: String) {
		countryListDataSource.isFiltering = isFiltering
		countryListDataSource.filteredCountries = countryListDataSource.countries.filter { (country: Country) -> Bool in
			return country.name.lowercased().contains(searchText.lowercased()) || country.capital.lowercased().contains(searchText.lowercased()) || country.demonym.lowercased().contains(searchText.lowercased())
		}
		tableView.reloadData()
	}
}
