//
//    ViewController.swift
//    Project1
//
//    Created by Joe Pham on 2021-01-03.
//

import UIKit

class ViewController: UITableViewController {
    // A property to store filenames outside of viewDidLoad()
    // Let's set it as empty String array for now
    // It'd be an array for all "nssl" pics for later reference rather than having to re-read the resources directory again and again
    // It's a variable as it'd be changed by the for loop later
    var pictures = [String]()
	
	let globalQueue = DispatchQueue.global()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Storm Viewer"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
		
		globalQueue.async { [weak self] in
			self?.loadImages()
		}
		
		tableView.reloadData()
	}
	
	func loadImages() {
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)
		
		for item in items {
			if item.hasPrefix("nssl") {
				pictures.append(item)
			}
		}
		
		pictures.sort()
	}
	
	@objc func shareTapped() {
		let activityVC = UIActivityViewController(activityItems: ["Check out this awesome storm viewer app"], applicationActivities: [])
		activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(activityVC, animated: true)
	}
    
    // Set how many rows to appear in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return length of array
        return pictures.count
    }
    
    // Specify how each row should look like
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Link to "Picture" in Main.storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        // Give text label of the cell the same value as a picture from the array
        // textLabel? optional chaining: "Execute only if there's an actual text label, otherwise do nothing"
        cell.textLabel?.text = pictures[indexPath.row]
        // indexPath.row contains the row number asked to low
        
        // Return the cell as a UITableViewCell to method
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: Try loading "Detail" view controller & type casting it to be DetailViewController
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: If success -> set property values over in DetailViewController.swift
            // Set "selectedImage" string value
            detailVC.selectedImage = pictures[indexPath.row]
            // Set values to selectedImagePosition & totalNumberOfImages
            detailVC.selectedImagePosition = indexPath.row + 1
            // "+1" to show human-readable index number instead of Swift index number approach
            
            detailVC.totalNumberOfImages = pictures.count
            // Equates total count of pictures array
            
            // 3: Now push it onto the navigation controller
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}


