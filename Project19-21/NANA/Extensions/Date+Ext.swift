//
//  Date+Ext.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-26.
//

import Foundation

extension Date {
	
	func convertToHourMinuteFormat() -> String {
		let formatter		= DateFormatter()
		formatter.timeStyle = .short
		return formatter.string(from: self)
	}
}
