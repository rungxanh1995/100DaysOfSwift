//
//  DetailViewController.swift
//  Project1
//
//  Created by Joe Pham on 2021-01-04.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!
  // Force unwrapping/IUO here is valid, tho it's initially nil
  // But by the time it's used, UIImageView gets loaded & the outlet gets connected, UIImageView would point to a real UIImageView
  
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
      // If success -> place imageToLoad into UIImage
      // then assign that to "image" property of "imageView" declared above
      imageView.image = UIImage(named: imageToLoad)
    }
  }
    
  // Hide bars on tap before the picture's view controller about to be shown
  override func viewWillAppear(_ animated: Bool) {
    // Inherits the method from UIViewController
    // Pass "animated" onto it to do its own processing
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  // Don't hide bars on tap before the picture's view controller about to go away
  // Aka not hide bars on tap in the main view controller
  override func viewWillDisappear(_ animated: Bool) {
    // Inherits the method from UIViewController
    // Pass "animated" onto it to do its own processing
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
