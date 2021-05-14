//
//  ViewController.swift
//  InstaFilter
//
//  Created by Joe Pham on 2021-05-12.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
	@IBOutlet var backgroundView: UIView!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var intensitySlider: UISlider!
	@IBOutlet var changeFilterLabel: UIButton! // challenge 2
	private var currentImage: UIImage!
	private var context: CIContext!
	private var currentFilter: CIFilter!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "InstaFilter"
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(importPicture))
		setUpBackgroundView()
		context = CIContext()
		currentFilter = CIFilter(name: FilterNames.sepiaFilter)
	}
}

extension ViewController {
	@IBAction func changeFilter(_ sender: UIButton) {
		let ac = UIAlertController(title: AlertContext.mainActionSheet.title,
								   message: nil,
								   preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: AlertContext.bumpDistortion.title,
								   style: .default,
								   handler: setFilter))
		ac.addAction(UIAlertAction(title: AlertContext.gaussianBlur.title,
								   style: .default,
								   handler: setFilter))
		ac.addAction(UIAlertAction(title: AlertContext.pixellate.title,
								   style: .default,
								   handler: setFilter))
		ac.addAction(UIAlertAction(title: AlertContext.sepiaTone.title,
								   style: .default,
								   handler: setFilter))
		ac.addAction(UIAlertAction(title: AlertContext.twirlDistortion.title,
								   style: .default,
								   handler: setFilter))
		ac.addAction(UIAlertAction(title: AlertContext.unsharpMask.title,
								   style: .default,
								   handler: setFilter))
		ac.addAction(UIAlertAction(title: AlertContext.vignette.title,
								   style: .default,
								   handler: setFilter))
		ac.addAction(UIAlertAction(title: AlertContext.cancelAction.title,
								   style: .cancel))
		
		ac.popoverPresentationController?.sourceView = sender
		ac.popoverPresentationController?.sourceRect = sender.bounds
		present(ac, animated: true)
	}
	
	@IBAction func save(_ sender: Any) {
		guard let image = imageView.image else {
			// challenge 1
			let ac = UIAlertController(title: AlertContext.noSourceImage.title,
									   message: AlertContext.noSourceImage.message,
									   preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: "OK",
									   style: .default))
			present(ac, animated: true)
			return
		}
		UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
	}
	
	@IBAction func intensityChanged(_ sender: Any) {
		filterImage()
	}
	
	@objc
	private func importPicture() {
		let picker = UIImagePickerController()
		picker.allowsEditing = true
		picker.delegate = self
		present(picker, animated: true)
	}
	
	private func processFilteringOnImage() {
		let beginImage = CIImage(image: currentImage)
		currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
		filterImage()
	}
	
	private func filterImage() {
		let inputKeys = currentFilter.inputKeys
		if inputKeys.contains(kCIInputIntensityKey) {
			currentFilter.setValue(intensitySlider.value, forKey: kCIInputIntensityKey)
		}
		if inputKeys.contains(kCIInputRadiusKey) {
			currentFilter.setValue(intensitySlider.value * 200, forKey: kCIInputRadiusKey)
		}
		if inputKeys.contains(kCIInputScaleKey) {
			currentFilter.setValue(intensitySlider.value * 10, forKey: kCIInputScaleKey)
		}
		if inputKeys.contains(kCIInputCenterKey) {
			currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
		}
		
		// actual processing executed here
		if let outputImage = currentFilter.outputImage,
		   let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
			let processedImage = UIImage(cgImage: cgImg)
			imageView.image = processedImage
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		guard let image = info[.editedImage] as? UIImage else { return }
		currentImage = image
		dismiss(animated: true)
		processFilteringOnImage()
	}
	
	private func setFilter(action: UIAlertAction) {
		guard currentImage != nil else { return }
		guard let filterName = action.title else { return }
		currentFilter = CIFilter(name: filterName) // update current filter with chosen filter name
		changeFilterLabel.setTitle("Filter: \(filterName)", for: .normal) // challenge 2
		processFilteringOnImage()
	}
}
