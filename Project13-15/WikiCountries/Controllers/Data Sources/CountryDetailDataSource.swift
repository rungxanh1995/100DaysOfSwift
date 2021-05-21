//
//  CountryDetailDataSource.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-20.
//

import UIKit

extension CountryDetailViewController {
	override func numberOfSections(in tableView: UITableView) -> Int {
		return sectionTitles.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch sectionTitles[section] {
		case .flag:			return 1
		case .general:		return 5
		case .languages:	return country.languages.count
		case .currencies:	return country.currencies.count
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return sectionTitles[section].rawValue
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch sectionTitles[indexPath.section] {
		case .flag:
			let cell = tableView.dequeueReusableCell(withIdentifier: Utils.flagCellIdentifier, for: indexPath)
			if let cell = cell as? FlagCell {
				cell.configure(for: country)
			}
			return cell
		case .general:
			let cell = tableView.dequeueReusableCell(withIdentifier: Utils.infoCellIdentifier, for: indexPath)
			cell.textLabel?.numberOfLines = 0
			switch indexPath.row {
			case 0: cell.textLabel?.text = buildName()
			case 1: cell.textLabel?.text = buildDemonym()
			case 2: cell.textLabel?.text = buildCapital()
			case 3: cell.textLabel?.text = buildPopulation()
			case 4: cell.textLabel?.text = buildArea()
			default: return cell
			}
			return cell
		case .languages:
			let cell = tableView.dequeueReusableCell(withIdentifier: Utils.infoCellIdentifier, for: indexPath)
			cell.textLabel?.numberOfLines = 0
			cell.textLabel?.text = buildLanguage(country.languages[indexPath.row])
			return cell
		case .currencies:
			let cell = tableView.dequeueReusableCell(withIdentifier: Utils.infoCellIdentifier, for: indexPath)
			cell.textLabel?.numberOfLines = 0
			cell.textLabel?.text = buildCurrency(country.currencies[indexPath.row])
			return cell
		}
	}
}

extension CountryDetailViewController {
	private func buildName() -> String {
		return "Name: \(country.name) (\(country.nativeName))"
	}
	
	private func buildDemonym() -> String {
		return "Demonym: \(country.demonym)"
	}
	
	private func buildCapital() -> String {
		return "Capital: \(country.capital)"
	}
	
	private func buildPopulation() -> String {
		if let population = Utils.numberFormatter.string(for: country.population) {
			return "Population: \(population)"
		}
		return "Population: unknown"
	}
	
	private func buildArea() -> String {
		if let area = Utils.numberFormatter.string(for: country.area) {
			return "Area: \(area) km²"
		}
		return "Area: unknown"
	}
	
	private func buildLanguage(_ language: Language) -> String {
		return "\(language.name) (\(language.nativeName))"
	}
	
	private func buildCurrency(_ currency: Currency) -> String {
		let name = currency.name ?? "Unknown name"
		let code = currency.code ?? "Unknown code"
		let symbol = currency.symbol ?? "Unknown symbol"
		return "\(name) (\(code), \(symbol))"
	}
	
	private func getSharedText() -> String {
		var text = """
		About \(country.name)
		General
		·\t\(buildName())
		·\t\(buildDemonym())
		·\t\(buildCapital())
		·\t\(buildPopulation())
		·\t\(buildArea())
		Languages
		"""
		for language in country.languages {
			text += "\n·\t\(buildLanguage(language))"
		}
		text.append(contentsOf: "\nCurrencies")
		for currency in country.currencies {
			text += "\n·\t\(buildCurrency(currency))"
		}
		return text
	}
	
	@objc
	func shareFacts() {
		Utils.hapticFeedback(from: .button)
		var shareItems = [Any]()
		if let flag = UIImage(named: Utils.getFlagFileName(code: (country.alpha2Code), type: .HD))?.pngData() {
			shareItems.append(flag)
		}
		shareItems.append(getSharedText())
		
		let vc = UIActivityViewController(activityItems: shareItems,
										  applicationActivities: nil)
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true)
	}
}