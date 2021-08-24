//
//  GraphicsView.swift
//  Core Graphics
//
//  Created by Joe Pham on 2021-08-20.
//

import UIKit.UIView

class GraphicsView: UIView {

	var imageView					= UIImageView(frame: .zero)
	var redrawButton				= UIButton(frame: .zero)
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func configure() {
		backgroundColor	= .systemBackground
		configureImageView()
		configureRedrawButton()
	}

	
	private func configureImageView() {
		imageView.backgroundColor	= .systemBackground
		imageView.contentMode		= .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: self.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
	
	
	private func configureRedrawButton() {
		redrawButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
		redrawButton.setTitle("Redraw", for: .normal)
		redrawButton.setTitleColor(.label, for: .normal)
		redrawButton.translatesAutoresizingMaskIntoConstraints = false
		addSubview(redrawButton)
		
		NSLayoutConstraint.activate([
			redrawButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			redrawButton.widthAnchor.constraint(equalToConstant: 200),
			redrawButton.heightAnchor.constraint(equalToConstant: 100),
			redrawButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}
