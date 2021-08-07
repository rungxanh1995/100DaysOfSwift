//
//  SSImageView.swift
//  SelfieShare
//
//  Created by Joe Pham on 2021-08-06.
//

import UIKit

class SSImageView: UIImageView {
		
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
		translatesAutoresizingMaskIntoConstraints = false
	}
}
