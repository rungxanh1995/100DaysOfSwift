//
//  CountryCell.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-19.
//

import UIKit

class CountryCell: UITableViewCell {
	@IBOutlet weak var flagImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var capitalNameLabel: UILabel!
	
	static let identifier = "CountryCell"
	/**
	Prepares the cell's UI before being used
	- author:
	Joe Pham
	- parameters:
		- country: The specific Country type for the cell
	*/
	func configure(for country: Country) {
		flagImageView.image = UIImage(named: Utils.getFlagFileName(code: country.alpha2Code, type: .SD))
		flagImageView.layer.borderWidth = 1
		flagImageView.layer.borderColor = UIColor.systemGray.cgColor
		flagImageView.layer.cornerRadius = 7
		flagImageView.layer.masksToBounds = true
		flagImageView.contentMode = .scaleAspectFill
		nameLabel.text = country.name
		capitalNameLabel.text = country.capital
	}
}
