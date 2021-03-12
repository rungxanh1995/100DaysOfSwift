//
//    ViewController.swift
//    Project1
//
//    Created by Joe Pham on 2021-01-03.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
	var picturesViewCount = [String: Int]()
	
	let mainQueue = DispatchQueue.main
	let globalQueue = DispatchQueue.global()
	let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true	// large title

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))	// a share button
        
		globalQueue.async { [weak self] in
			self?.loadImages()
        }
		
		// DEFINE USERDEFAULTS DATA UNPACKING
		picturesViewCount = defaults.object(forKey: "LastViewCount") as? [String: Int] ?? [String: Int]()
		
        tableView.reloadData()
    }
	
	// METHOD TO LOAD THE IMAGES
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
    
    // SET HOW MANY ROWS TO APPEAR IN TABLE VIEW
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return length of array
        return pictures.count
    }
    
    // SPECIFY HOW EACH ROW SHOULD LOOK LIKE
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Link to "Picture" in Main.storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
		cell.detailTextLabel?.text = "Viewed: \(picturesViewCount[pictures[indexPath.row]] ?? 0) times"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.selectedImage = pictures[indexPath.row]
            detailVC.selectedImagePosition = indexPath.row + 1
            // "+1" to show human-readable index number instead of Swift index number approach
            
            detailVC.totalNumberOfImages = pictures.count
			
			picturesViewCount[pictures[indexPath.row], default: 0] += 1	// increment view count upon cell selection
			
			globalQueue.async { [weak self] in
				self?.saveViewCount()
				
				self?.mainQueue.async {
					self?.navigationController?.pushViewController(detailVC, animated: true)
					self?.tableView.reloadRows(at: [indexPath], with: .none)	// update the view count live in each tableView cell
				}
			}
        }
    }
    
    // METHOD TO RECOMMEND APP TO OTHER PEOPLE VIA SHARING BUTTON
    @objc func shareTapped() {
		var shareItems: [Any] = ["Check out this awesome Storm Viewer app"]
		if let url = URL(string: "https://www.hackingwithswift.com/100/16") {
			shareItems.append(url)
		}
		
        let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: [])
        activityVC.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityVC, animated: true)
    }
	
	// METHOD TO SAVE DATA TO USERDEFAULTS
	func saveViewCount() {
		defaults.set(picturesViewCount, forKey: "LastViewCount")
	}
}
