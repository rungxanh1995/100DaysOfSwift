//
//  NoteCell.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import UIKit


class NoteCell: UITableViewCell {
	
	static let resuseIdentifier = "NoteCell"
	
	let noteTitle			= NATitleLabel(textAlignment: .natural)
	let noteContent			= NASubtitleLabel(textAlignment: .natural)
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func set(for note: Note) {
		noteTitle.text		= note.title
		noteContent.text	= note.content
	}
	
	
	private func configure() {
		addSubviews(noteTitle, noteContent)
		accessoryType = .disclosureIndicator
		
		let edgePadding: CGFloat	= 16
		let padding: CGFloat		= 10
		let height: CGFloat			= 24
		
		NSLayoutConstraint.activate([
			noteTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
			noteTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgePadding),
			noteTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgePadding),
			noteTitle.heightAnchor.constraint(equalToConstant: height),
			
			noteContent.heightAnchor.constraint(equalToConstant: height),
			noteContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgePadding),
			noteContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgePadding),
			noteContent.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
		])
	}
}
