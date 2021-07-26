//
//  Constants.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import UIKit


enum Images {
	static let note						= UIImage(systemName: "square.and.pencil")!
	static let trash					= UIImage(systemName: "trash")!
}


enum Messages {
	static let noNotes					= "No Notes.\nTap Compose button to add one!"
	static let somethingWrong			= "Something went wrong"
	static let unableToDelete			= "Unable to delete note."
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
