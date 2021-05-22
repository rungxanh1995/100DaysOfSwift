//
//  FlagCell.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-19.
//

import UIKit

class FlagCell: UITableViewCell {
	@IBOutlet weak var flagImageView: UIImageView!
	
	static let identifier = "FlagCell"
	/**
	Prepares the cell's UI before being used
	- author:
	Joe Pham
	- parameters:
		- country: The specific Country type for the flag
	*/
	func configure(for country: Country) {
		flagImageView.image = UIImage(named: Utils.getFlagFileName(code: country.alpha2Code, type: .HD))
		flagImageView.layer.borderWidth = 1
		flagImageView.layer.borderColor = UIColor.systemGray.cgColor
		flagImageView.layer.cornerRadius = 7
		flagImageView.layer.masksToBounds = true
		flagImageView.contentMode = .scaleAspectFill
	}
}
