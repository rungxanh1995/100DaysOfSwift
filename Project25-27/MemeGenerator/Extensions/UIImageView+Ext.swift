//
//  UIImageView+Ext.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-29.
//	Referenced code from Guillaume A. at github.com/clarknt

import UIKit


extension UIImageView {
	
	func imageWithCaption(from sourceImage: UIImage, with text: String, captionPosition position: CaptionPosition) -> UIImage? {
		guard let imageSize = self.image?.size else { return nil }
		let renderer = UIGraphicsImageRenderer(size: imageSize)
		
		let image = renderer.image { context in
			
			sourceImage.draw(at: CGPoint(x: 0, y: 0))
			
			
			switch position {
			
			case .top:
				drawCaption(captionString: text.uppercased(), captionPosition: .top, rendererSize: imageSize)
				
			case .bottom:
				drawCaption(captionString: text.uppercased(), captionPosition: .bottom, rendererSize: imageSize)
			}
		}
		
		return image
	}
	
	
	fileprivate func drawCaption(captionString string: String, captionPosition position: CaptionPosition, rendererSize: CGSize) {
		
		let paragraphStyle			= NSMutableParagraphStyle()
		paragraphStyle.alignment	= .center
		
		// accomodate all images sizes
		let sidesLength				= rendererSize.width + rendererSize.height
		let fontSize				= sidesLength / 30
		
		let attrs: [NSAttributedString.Key : Any] = [
			.foregroundColor: UIColor.white,
			.font			: UIFont.systemFont(ofSize: fontSize, weight: .bold),
			.paragraphStyle	: paragraphStyle
		]
		
		let margin = 32
		let textWidth = Int(rendererSize.width) - (margin * 2)
		let textHeight = computeTextHeight(for: string, attributes: attrs, width: textWidth)
		
		var startY: Int
		switch position {
		case .top:
			startY = margin
		case .bottom:
			startY = Int(rendererSize.height) - (textHeight + margin)
		}
		
		string.draw(with: CGRect(x: margin, y: startY, width: textWidth, height: textHeight), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
	}
	
	
	fileprivate func computeTextHeight(for string: String, attributes: [NSAttributedString.Key : Any], width: Int) -> Int {
		let nsText		= NSString(string: string)
		let size		= CGSize(width: CGFloat(width), height: .greatestFiniteMagnitude)
		let textRect	= nsText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
		
		return Int(ceil(textRect.size.height))
	}
}
