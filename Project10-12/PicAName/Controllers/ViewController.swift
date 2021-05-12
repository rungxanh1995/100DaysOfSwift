//
//  ViewController.swift
//  PicAName
//
//  Created by Joe Pham on 2021-04-18.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	var pictures = [Picture]()
	
	static let viewControllerCellIdentifier = "Cell"
	static let detailViewControllerIdentifier = "DetailViewController"
	
	func showPicker(fromCamera: Bool) {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		picker.sourceType = fromCamera ? .camera : .photoLibrary
		present(picker, animated: true, completion: nil)
	}
	
	@objc
	func addPicture() {
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let ac = UIAlertController(title: "Image Source",
									   message: "Choose where to add your new picture",
									   preferredStyle: .actionSheet)
			ac.addAction((UIAlertAction(title: "Camera",
										style: .default,
										handler: { [weak self] _ in
											self?.showPicker(fromCamera: true)
											
										})))
			ac.addAction((UIAlertAction(title: "Photo Library",
										style: .default,
										handler: { [weak self] _ in
											self?.showPicker(fromCamera: false)
										})))
			ac.addAction(UIAlertAction(title: "Cancel",
									   style: .cancel,
									   handler: nil))
			ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
			present(ac, animated: true, completion: nil)
		} else {
			showPicker(fromCamera: false)
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage] as? UIImage else { return }
		DispatchQueue.global().async { [weak self] in
			let imageName = UUID().uuidString
			if let jpegData = image.jpegData(compressionQuality: 0.8) {
				try? jpegData.write(to: Utils.getImageURL(for: imageName))
			}
			DispatchQueue.main.async {
				self?.dismiss(animated: true, completion: nil)
				
				let ac = UIAlertController(title: "New Caption",
										   message: "Enter a caption for this picture",
										   preferredStyle: .alert)
				ac.addTextField()
				ac.addAction(UIAlertAction(title: "OK",
										   style: .default,
										   handler: { [weak ac] _ in
											guard let caption = ac?.textFields?[0].text else { return }
											self?.savePicture(imageName: imageName, caption: caption)
										   }))
				ac.addAction(UIAlertAction(title: "Cancel",
										   style: .cancel,
										   handler: nil))
				self?.present(ac, animated: true, completion: nil)
			}
		}
	}

	func savePicture(imageName: String, caption: String) {
		let picture = Picture(imageName: imageName, caption: caption)
		pictures.append(picture)
		
		DispatchQueue.global().async { [weak self] in
			if let pictures = self?.pictures {
				Utils.savePictures(pictures: pictures)
			}
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "PicAName"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPicture))
		tableView.rowHeight = 99
		DispatchQueue.global().async { [weak self] in
			self?.pictures = Utils.loadPictures()
			DispatchQueue.main.async {
				self?.tableView.reloadData()
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}

	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pictures.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.viewControllerCellIdentifier, for: indexPath) as? PictureCell else {
			fatalError("Unable to dequeue PictureCell")
		}
		cell.pictureLabel?.text = pictures[indexPath.row].caption
		let fileAtPath = Utils.getImageURL(for: pictures[indexPath.row].imageName).path
		cell.pictureView?.image = UIImage(contentsOfFile: fileAtPath)
		cell.pictureView?.contentMode = .scaleAspectFill
		cell.pictureView?.layer.borderColor = UIColor.systemGray.cgColor
		cell.pictureView?.layer.borderWidth = 0.1
		cell.pictureView?.layer.cornerRadius = 5
		cell.pictureView?.layer.masksToBounds = true
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		DispatchQueue.global().async { [weak self] in
			self?.pictures.remove(at: indexPath.row)
			if let pictures = self?.pictures {
				Utils.savePictures(pictures: pictures)
			}
		}
		DispatchQueue.main.async {
			tableView.performBatchUpdates {
				tableView.deleteRows(at: [indexPath], with: .automatic)
			} completion: { _ in
				tableView.reloadData()
			}
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let vc = storyboard?.instantiateViewController(withIdentifier: Self.detailViewControllerIdentifier) as? DetailViewController else { return }
		vc.picture = pictures[indexPath.row]
		navigationController?.pushViewController(vc, animated: true)
	}
}
