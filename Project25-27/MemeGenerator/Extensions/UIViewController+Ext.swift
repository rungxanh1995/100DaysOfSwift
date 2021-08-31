//
//  UIViewController+Ext.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-30.
//

import UIKit

extension UIViewController {
	
	func presentCaptionPrompt(via action: UIAction, for captionPosition: CaptionPosition, completed: @escaping (String?) -> Void) {
		
		var positionString: String
		switch captionPosition {
		case .top:		positionString = "Top"
		case .bottom:	positionString = "Bottom"
		}
		
		let ac = UIAlertController(title: "New \(positionString) Caption", message: nil, preferredStyle: .alert)
		ac.addTextField()
		
		let addAction = UIAlertAction(title: "Add", style: .default, handler: { [weak ac] action in
			guard let caption = ac?.textFields?[0].text else { return }
			completed(caption)
		})
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
			completed(nil)
		}
		
		ac.addActions(addAction, cancelAction)
		present(ac, animated: true)
	}
}
