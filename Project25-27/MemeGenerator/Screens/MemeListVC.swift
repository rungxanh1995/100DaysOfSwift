//
//  MemeListVC.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-29.
//

import UIKit

class MemeListVC: UIViewController {
	
	// MARK: Properties
	// For UI
	var collectionView			: UICollectionView!
	private var images			= [UIImage]()
	private var imageIndex		= 0
	
	
	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureViewController()
		configureCollectionView()
	}


}


extension MemeListVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	final func importPicture(via action: UIAction, using type: UIImagePickerController.SourceType) {
		let picker				= UIImagePickerController()
		picker.sourceType		= type
		picker.allowsEditing	= false
		picker.delegate			= self
		present(picker, animated: true)
	}
	
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.originalImage] as? UIImage else { return }
		dismiss(animated: true)
	
		updateSourceData(with: image)
	}
}


extension MemeListVC: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:MemeCell.reuseID, for: indexPath) as? MemeCell else { return UICollectionViewCell()
		}
		let memeImage = images[indexPath.item]
		cell.set(with: memeImage)
		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
}


extension MemeListVC: UICollectionViewDelegate {
	
	final func configureViewController() {
		view.backgroundColor	= .systemBackground
		title					= Bundle.main.displayName
		let spacer				= UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		setToolbarItems([spacer, configureAddButton()], animated: true)
		navigationController?.isToolbarHidden = false
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	
	final func configureAddButton() -> UIBarButtonItem {
		
		let camera	= UIAction(title: "Photos from Camera", image: SFSymbol.camera, handler: { [weak self] (action) in self?.importPicture(via: action, using: .camera)
		})
		
		let library	= UIAction(title: "Photos from Library", image: SFSymbol.photoLibrary, handler: { [weak self] (action) in self?.importPicture(via: action, using: .photoLibrary)
		})
		
		var actions	= [UIAction]()
		#if targetEnvironment(simulator)
		actions		= [library]
		#else
		actions		= [camera, library]
		#endif
		let menu = UIMenu(title: "Photo Source", image: nil, identifier: nil, options: [], children: actions)
		return UIBarButtonItem(title: nil, image: SFSymbol.add, primaryAction: nil, menu: menu)
	}
	
	
	final func configureCollectionView() {
		let flowLayout					= UICollectionViewFlowLayout()
		flowLayout.configureTwoColumnFlowLayout(in: view)
		
		collectionView					= UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
		collectionView.backgroundColor 	= .systemBackground
		collectionView.dataSource		= self
		collectionView.delegate			= self
		collectionView.register(MemeCell.self, forCellWithReuseIdentifier: MemeCell.reuseID)
		view.addSubview(collectionView)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		imageIndex				= indexPath.item
		let selectedMeme		= images[imageIndex]
		let destVC				= MemeDetailVC(image: selectedMeme, delegate: self)
		let navController 		= UINavigationController(rootViewController: destVC)
		present(navController, animated: true)
	}
}


extension MemeListVC: MemeListVCDelegate {
	
	func didReceiveImage(_ image: UIImage) {
		images[imageIndex] = image
		collectionView.reloadData()
	}
}


extension MemeListVC {
	
	func updateSourceData(with image: UIImage) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.images.insert(image, at: 0)
			self.collectionView.reloadData()
		}
	}
}

