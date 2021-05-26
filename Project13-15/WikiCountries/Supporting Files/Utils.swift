//
//  Constants.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-19.
//

import UIKit
import CoreHaptics

struct Utils {
	static let mainStoryboardName = "Main"
	static let detailStoryboardIdentifier = "CountryDetailViewController"
	static let infoCellIdentifier = "Info"
	static let jsonSourceURL = "https://restcountries.eu/rest/v2/all?fields=name;alpha2Code;capital;population;demonym;area;nativeName;currencies;languages;flag"
	
	static let prefixSD = "flag_sd_"
	static let prefixHD = "flag_hd_"
	static let fileExtension = ".png"
	
	static let numberFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter
	}()
	
	enum FlagType {
		case HD
		case SD
	}
	
	static func getFlagFileName(code: String, type: FlagType) -> String {
		return getFlagPrefix(type: type) + code + fileExtension
	}
	
	static func getFlagPrefix(type: FlagType) -> String {
		switch type {
		case .HD:
			return Utils.prefixHD
		case .SD:
			return Utils.prefixSD
		}
	}
}

extension Utils {
	static var isHapticAvailable: Bool {
		return CHHapticEngine.capabilitiesForHardware().supportsHaptics
	}
	enum Haptic {
		case cell
		case button
	}
	
	static func hapticFeedback(from element: Haptic) {
		switch element {
		case .cell:
			let generator = UIImpactFeedbackGenerator(style: .medium)
			generator.impactOccurred(intensity: 1.0)
		case .button:
			let generator = UINotificationFeedbackGenerator()
			generator.notificationOccurred(.success)
		}
	}
}
