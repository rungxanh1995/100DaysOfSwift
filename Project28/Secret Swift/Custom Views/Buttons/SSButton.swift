//
//  SSButton.swift
//  Secret Swift
//
//  Created by Joe Pham on 2021-09-02.
//

import UIKit

class SSButton: UIButton {

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(backgroundColor: UIColor, title: String) {
		self.init(frame: .zero)
		self.backgroundColor = backgroundColor
		self.setTitle(title, for: .normal)
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints	= false
		layer.cornerRadius 							= 10
		contentEdgeInsets							= UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
		titleLabel?.font							= UIFont.preferredFont(forTextStyle: .headline)
		setTitleColor(UIColor.white, for: .normal)

	}
	
	func set(backgroundColor: UIColor, title: String) {
		self.backgroundColor = backgroundColor
		setTitle(title, for: .normal)
	}
	
}
