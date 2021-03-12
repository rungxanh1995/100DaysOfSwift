//
//  ViewController.swift
//  Project1-3
//
//  Created by Joe Pham on 2021-01-08.
//

import UIKit

class ViewController: UITableViewController {
  var flagNames = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    // Title of main view controller
    title = "Flag Watch"
    // Enable large titles
    navigationController?.navigationBar.prefersLargeTitles = true
    
    // Initialize file manager handler & search for file items
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)
    
    // Search for .png files
    for item in items {
      if item.hasSuffix("png") {
        // This is the picture to load
        flagNames.append(item)
        flagNames.sort()
      }
      // Print filenames to debug console
      print(flagNames)
    }
  }
  
  // Set rows of table view
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return flagNames.count
  }

  // Define what & how each row displays
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
    cell.textLabel?.text = String(flagNames[indexPath.row].getFileName().dropLast(3)).capitalized
    cell.imageView?.image = UIImage(named: flagNames[indexPath.row])
    cell.imageView?.layer.borderWidth = 1
    cell.imageView?.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    return cell
  }
  
  // Link selected flag image to detail view controller
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Attempt to typecast as DetailViewController
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
      // If success, set value of its selectedImage
      vc.selectedImage = flagNames[indexPath.row]
      // Then push it into navigation controller
      navigationController?.pushViewController(vc, animated: true)
      // Now there's a link between main view & detail view
    }
  }
}

// Extension to String type to enable splitting filename from extension part
// This extension is also by default available to other Swift files in this app bundle
extension String {
  func getFileName() -> String {
    return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
  }
  
  func getFileExtension() -> String {
    return URL(fileURLWithPath: self).pathExtension
  }
}

