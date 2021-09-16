//
//  Constants.swift
//  Exploding Monkeys
//
//  Created by Joe Pham on 2021-09-05.
//

import UIKit

enum NodeNames {
	static let banana					= "banana"
	static let building					= "building"
	static let monkey					= "monkey"
	static let player1					= "1"
	static let player2					= "2"
}


enum Colors {
	static let sky						= UIColor(named: "sky")!
	static let buildingLightOn			= UIColor(named: "buildingLightOn")!
	static let buildingLightOff			= UIColor(named: "buildingLightOff")!
	static let building1				= UIColor(named: "building1")!
	static let building2				= UIColor(named: "building2")!
	static let building3				= UIColor(named: "building3")!
}


enum Display {
	static let width 					= UIScreen.main.bounds.width
	static let height 					= UIScreen.main.bounds.height
	static let leftEdge					= CGFloat(0)
	static let rightEdge				= width
	static let bottomEdge				= CGFloat(0)
	static let topEdge					= height
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
