//
//  CountryListDataSource.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-19.
//

import UIKit

class CountryListDataSource: NSObject {
	var countries = [Country]()
	var filteredCountries = [Country]()
	var isFiltering = false
	
	func country(at row: Int) -> Country {
		if isFiltering {
			return filteredCountries[row]
		}
		return countries[row]
	}
}

extension CountryListDataSource: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isFiltering {
			return filteredCountries.count
		}
		return countries.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
				withIdentifier: CountryCell.identifier,
				for: indexPath)
				as? CountryCell else {
			fatalError("Unable to dequeue CountryCell")
		}
		let country = country(at: indexPath.row)
		cell.configure(for: country)
		return cell
	}
}
