//
//  DetailViewController.swift
//  PicAName
//
//  Created by Joe Pham on 2021-05-11.
//

import UIKit

class DetailViewController: UIViewController {
	
	@IBOutlet var imageView: UIImageView!
	var pictures: [Picture]!
	var picture: Picture!
	
	@objc
	func editTapped() {
		let ac = UIAlertController(title: "New Caption",
								   message: nil,
								   preferredStyle: .alert)
		ac.addTextField()
		ac.addAction(UIAlertAction(
						title: "OK",
						style: .default,
						handler: { [weak self, weak ac] _ in
							if let caption = ac?.textFields?[0].text {
								self?.picture.caption = caption
								
								DispatchQueue.global().async {
									if let pictures = self?.pictures {
										Utils.savePictures(pictures: pictures)
									}
									DispatchQueue.main.async {
										self?.title = self?.picture.caption
									}
								}
							}
						}))
		ac.addAction(UIAlertAction(
						title: "Cancel",
						style: .cancel,
						handler: nil))
		present(ac, animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = picture.caption
		navigationItem.largeTitleDisplayMode = .never
		let fileAtPath = Utils.getImageURL(for: picture.imageName).path
		imageView.image = UIImage(contentsOfFile: fileAtPath)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.hidesBarsOnTap = false
	}
}
