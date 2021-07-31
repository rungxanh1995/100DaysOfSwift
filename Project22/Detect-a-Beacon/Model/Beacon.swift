//
//  Beacon.swift
//  Detect-a-Beacon
//
//  Created by Joe Pham on 2021-07-30.
//

import Foundation


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
