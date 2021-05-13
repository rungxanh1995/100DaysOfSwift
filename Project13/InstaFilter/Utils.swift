//
//  Utils.swift
//  InstaFilter
//
//  Created by Joe Pham on 2021-05-13.
//

import UIKit

struct FilterNames {
	static let bumpDistortionFilter		= "CIBumpDistortion"
	static let gaussianBlurFilter 		= "CIGaussianBlur"
	static let pixellateFilter			= "CIPixellate"
	static let sepiaFilter				= "CISepiaTone"
	static let twirlDistortionFilter 	= "CITwirlDistortion"
	static let unsharpMaskFilter		= "CIUnsharpMask"
	static let vignetteFilter			= "CIVignette"
}

struct AlertItem {
	var title: String
	var message: String?
}

struct AlertContext {
	static let mainActionSheet	= AlertItem(title: "Choose A Filter")
	static let bumpDistortion	= AlertItem(title: FilterNames.bumpDistortionFilter)
	static let gaussianBlur		= AlertItem(title: FilterNames.gaussianBlurFilter)
	static let pixellate		= AlertItem(title: FilterNames.pixellateFilter)
	static let sepiaTone		= AlertItem(title: FilterNames.sepiaFilter)
	static let twirlDistortion	= AlertItem(title: FilterNames.twirlDistortionFilter)
	static let unsharpMask		= AlertItem(title: FilterNames.unsharpMaskFilter)
	static let vignette			= AlertItem(title: FilterNames.vignetteFilter)
	static let cancelAction		= AlertItem(title: "Cancel")
	
	static let imageSavingError	= AlertItem(title: "Saving Error")
	static let imageSaved		= AlertItem(title: "Saved",
											 message: "Edited image is saved to Photo Library")
}

extension ViewController {
	func setUpBackgroundView() {
		backgroundView.backgroundColor = .systemGray
		backgroundView.layer.cornerRadius = 12
		backgroundView.layer.masksToBounds = true
	}
	
	@objc
	func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
		// function to be called when saving image to Photo Library
		var title: String = ""
		var message: String! = ""
		if let error = error {
			title = AlertContext.imageSavingError.title
			message = error.localizedDescription
		} else {
			title = AlertContext.imageSaved.title
			message = AlertContext.imageSaved.message
		}
		
		let ac = UIAlertController(title: title,
								   message: message,
								   preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "OK",
								   style: .default))
		present(ac, animated: true)
	}
}
