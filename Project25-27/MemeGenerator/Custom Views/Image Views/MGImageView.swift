//
//  MGImageView.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-29.
//

import UIKit

class MGImageView: UIImageView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		layer.cornerRadius 	= 10
		clipsToBounds 		= true
		contentMode			= .scaleAspectFit
		translatesAutoresizingMaskIntoConstraints = false
	}
}
