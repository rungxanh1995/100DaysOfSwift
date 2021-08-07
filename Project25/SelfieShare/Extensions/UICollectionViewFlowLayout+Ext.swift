//
//  UICollectionViewFlowLayout+Ext.swift
//  SelfieShare
//
//  Created by Joe Pham on 2021-08-06.
//

import UIKit

extension UICollectionViewFlowLayout {
	
	func configureTwoColumnFlowLayout(in view: UIView) {
		let width 				= view.bounds.size.width
		let padding				= CGFloat(12)
		let minItemSpacing		= CGFloat(8)
		let availableWidth 		= width - (padding * 2) - (minItemSpacing * 2)
		let itemWidth			= availableWidth / 2
		
		itemSize				= CGSize(width: itemWidth, height: itemWidth)
		sectionInset			= UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
	}
}
