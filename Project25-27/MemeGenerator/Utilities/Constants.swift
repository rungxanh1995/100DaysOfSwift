//
//  Constants.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-29.
//

import UIKit


enum SFSymbol {
	static let add						= UIImage(systemName: "plus")
	static let stop						= UIImage(systemName: "nosign")
	static let camera					= UIImage(systemName: "camera")
	static let photoLibrary				= UIImage(systemName: "photo.on.rectangle.angled")
	static let caption					= UIImage(systemName: "captions.bubble")
	static let topCaption				= UIImage(systemName: "rectangle.topthird.inset")
	static let bottomCaption			= UIImage(systemName: "rectangle.bottomthird.inset.fill")
}


enum CaptionPosition {
	case top
	case bottom
}


enum ScreenSize {
	static let width					= UIScreen.main.bounds.size.width
	static let height					= UIScreen.main.bounds.size.height
	static let maxLength				= max(ScreenSize.width, ScreenSize.height)
	static let maxWidth					= min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
	static let idiom					= UIDevice.current.userInterfaceIdiom
	static let nativeScale				= UIScreen.main.nativeScale
	static let scale					= UIScreen.main.scale
	
	static let isiPhoneSE				= idiom == .phone && ScreenSize.maxLength == 568.0
	static let isiPhone8Standard		= idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
	static let isiPhone8Zoomed			= idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
	static let isiPhone8PlusStandard	= idiom == .phone && ScreenSize.maxLength == 736.0
	static let isiPhone8PlusZoomed		= idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
	static let isiPhoneX				= idiom == .phone && ScreenSize.maxLength == 812.0
	static let isiPhoneXsMaxAndXr		= idiom == .phone && ScreenSize.maxLength == 896.0
	static let isiPad					= idiom == .pad && ScreenSize.maxLength >= 1024.0
	
	static func isiPhoneXAspectRatio() -> Bool { return isiPhoneX || isiPhoneXsMaxAndXr	}
}
