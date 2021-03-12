//
//  DetailViewController.swift
//  Project1-3
//
//  Created by Joe Pham on 2021-01-08.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet var imageView: UIImageView!
  
  // Declare optional name of selected image
  var selectedImage: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    // Set title name to selected image
    title = String(selectedImage!.getFileName().dropLast(3).capitalized)
    // Disable large title
    navigationItem.largeTitleDisplayMode = .never
    
    // Create sharing button in detail view
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    
    // Load image data from selected image to UIImage
    if let imageToLoad = selectedImage {
      imageView.image = UIImage(named: imageToLoad)
    }
  }
  
  // Enable hiding bars on tap when detail view about to appear from main view
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  // Disable hiding bars on tap when detail view about to disappear
  // aka after transitioned from detail view to main view
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
  
  // Method for when sharing button is tapped
  @objc func shareTapped() {
    // Guard code to hold image data of the flag
    guard let image = imageView.image?.pngData() else {
      print("No flag image found!")
      return
    }
    // Define content & styling of share sheet
    let vc = UIActivityViewController(activityItems: [image, "Flag of \(title!)"], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
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
