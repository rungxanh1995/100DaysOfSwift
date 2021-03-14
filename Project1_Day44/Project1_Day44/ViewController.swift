//
//  ViewController.swift
//  Project1_Day44
//
//  Created by Joe Pham on 2021-03-13.
//

import UIKit

let mainQueue = DispatchQueue.main
let globalQueue = DispatchQueue.global()

class ViewController: UICollectionViewController {
	var pictures = [String]()

	// MARK: - viewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Storm Viewer"
		navigationController?.navigationBar.prefersLargeTitles = true	// large title
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))	// a share button
		
		globalQueue.async { [weak self] in
			self?.loadPictures()
		}
	}
	
	// MARK: - Mainline functions
	func loadPictures() {
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		let items = try! fm.contentsOfDirectory(atPath: path)
		
		for item in items {
			if item.hasPrefix("nssl") {
				pictures.append(item)
			}
		}
		pictures.sort()
		print("Pictures: \(pictures)")
		
		mainQueue.async { self.collectionView.reloadData() }
	}
	
	@objc func shareTapped() {
		var shareItems: [Any] = ["Check out this awesome Storm Viewer app"]
		if let url = URL(string: "https://www.hackingwithswift.com/100/44") {
			shareItems.append(url)
		}
		
		let vc = UIActivityViewController(activityItems: shareItems, applicationActivities: [])
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem	// for iPad
		present(vc, animated: true)
	}

	// MARK: - Collection view functions
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pictures.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Storm", for: indexPath) as? StormCell else {
			fatalError("Error: Cannot dequeue reusable cell.")
		}
		cell.imageView.image = UIImage(named: pictures[indexPath.row])
		cell.name?.text = pictures[indexPath.row]
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
			vc.selectedImage = pictures[indexPath.row]
			vc.selectedImagePosition = indexPath.row + 1
			// "+1" to show human-readable index number instead of Swift index number approach
			
			vc.totalNumberOfImages = pictures.count
			// present(vc, animated: true)
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}

