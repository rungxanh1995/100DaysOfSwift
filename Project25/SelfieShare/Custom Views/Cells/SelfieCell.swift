//
//  SelfieCell.swift
//  SelfieShare
//
//  Created by Joe Pham on 2021-08-06.
//

import UIKit

class SelfieCell: UICollectionViewCell {
	
	static let reuseID				= "SelfieCell"
	
	let selfieImageView				= SSImageView(frame: .zero)
//	let selfieNameLabel 			= SSTitleLabel(textAlignment: .center, fontSize: 16)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
//		selfieNameLabel.text		= nil
		selfieImageView.image		= Images.avatarPlaceholder
	}
	
	
	private func configure() {
		selfieImageView.tag			= 1000
		selfieImageView.contentMode = .scaleAspectFill
		addSubviews(selfieImageView)
		
		let padding: CGFloat		= 8
		NSLayoutConstraint.activate([
			selfieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
			selfieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			selfieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			selfieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
			
//			selfieNameLabel.topAnchor.constraint(equalTo: selfieImageView.bottomAnchor, constant: 12),
//			selfieNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
//			selfieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
//			selfieNameLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
}
