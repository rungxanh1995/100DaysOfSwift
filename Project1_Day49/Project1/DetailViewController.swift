//
//  DetailViewController.swift
//  Project1
//
//  Created by Joe Pham on 2021-01-04.
//

import UIKit

class DetailViewController: UIViewController {
	@IBOutlet var imageView: UIImageView!
	
	// Create a var to hold name of the image to load (as optional initially)
	var selectedImage: String?
	// Declare vars to display name as image position of selected image
	var selectedImagePosition: Int = 0
	var totalNumberOfImages: Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		// Title with position of a selected picture
		title = "Image \(selectedImagePosition) of \(totalNumberOfImages)"
		
		// Disable large title in detail view screen
		navigationItem.largeTitleDisplayMode = .never
		
		if let imageToLoad = selectedImage {
			// If success
			imageView.image = UIImage(named: imageToLoad)
		}
		
	}
	
	// Hide bars on tap before the picture's view controller about to be shown
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.hidesBarsOnTap = true
	}
	
	// Don't hide bars on tap before the picture's view controller about to go away
	// Aka not hide bars on tap in the main view controller
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.hidesBarsOnTap = false
	}
}
