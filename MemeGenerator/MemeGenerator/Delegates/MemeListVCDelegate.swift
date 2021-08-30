//
//  MemeListVCDelegate.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-29.
//

import UIKit

protocol MemeListVCDelegate: AnyObject {
	
	/**
	Updates the image in MemeListVC automatically upon closing the detail view
	
	- parameters:
		- image: The image with captions (if any) from the detail view
	*/
	
	func didReceiveImage(_ image: UIImage)
	
}
