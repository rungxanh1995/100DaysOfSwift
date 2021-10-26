//
//  MemeCell.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-29.
//

import UIKit

class MemeCell: UICollectionViewCell {
	
	static let reuseID				= "MemeCell"
	
	let memeImageView				= MGImageView(frame: .zero)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	
	func set(with image: UIImage) {
		memeImageView.image = image
	}
	
	
	private func configure() {
		memeImageView.contentMode	= .scaleAspectFill
		addSubviews(memeImageView)
		
		let padding: CGFloat		= 8
		NSLayoutConstraint.activate([
			memeImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			memeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			memeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
			memeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
		])
	}
}
