//
//  Constants.swift
//  Detect-a-Beacon
//
//  Created by Joe Pham on 2021-07-28.
//

import UIKit


struct Beacon {
	let name:		String
	let uuidString: UUID
	let major:		UInt16
	let minor:		UInt16
}


extension Beacon {
	static let mockData = [
		Beacon(name: "AirLocate 5A4BCFCE", uuidString: UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!, major: 123, minor: 456),
		Beacon(name: "AirLocate 74278BDA", uuidString: UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935")!, major: 123, minor: 456),
		Beacon(name: "AirLocate E2C56DB5", uuidString: UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")!, major: 123, minor: 456),
		Beacon(name: "TwoCanoes 92AB49BE", uuidString: UUID(uuidString: "92AB49BE-4127-42F4-B532-90fAF1E26491")!, major: 123, minor: 456),
		Beacon(name: "Radius Network 2F234454", uuidString: UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6")!, major: 123, minor: 456)
	]
}


enum DistanceLabelText {
	static let unknown		= "UNKNOWN"
	static let far			= "FAR"
	static let near			= "NEARBY"
	static let immediate	= "RIGHT HERE"
}


enum Images {
	static let wave			= UIImage(systemName: "wave.3.right.circle.fill")!
}


enum ScreenSize {
	static let width		= UIScreen.main.bounds.size.width
	static let height		= UIScreen.main.bounds.size.height
	static let maxLength	= max(ScreenSize.width, ScreenSize.height)
	static let maxWidth		= min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
	static let idiom		= UIDevice.current.userInterfaceIdiom
	static let nativeScale	= UIScreen.main.nativeScale
	static let scale		= UIScreen.main.scale
	
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
