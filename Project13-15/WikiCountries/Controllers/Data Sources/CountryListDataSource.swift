//
//  CountryListDataSource.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-19.
//

import UIKit

class CountryListDataSource: NSObject {
	private var countries: [Country] = []
	
	func country(at row: Int) -> Country {
		return countries[row]
	}
	
	func loadData() {
		if let url = URL(string: Utils.countrySourceURL) {
			do {
				let data = try Data(contentsOf: url)
				let decodedCountries = try? JSONDecoder().decode(Countries.self, from: data)
				countries = decodedCountries ?? []
			}
			catch let error {
				print("Data or JSONDecoder error: \(error.localizedDescription)")
			}
		}
	}
}

extension CountryListDataSource: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return countries.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
				withIdentifier: Utils.countryCellIdentifier,
				for: indexPath)
				as? CountryCell else {
			fatalError("Unable to dequeue CountryCell")
		}
		let country = country(at: indexPath.row)
		cell.configure(for: country)
		return cell
	}
}
