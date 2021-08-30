//
//  Bundle+Ext.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-29.
//

import Foundation

extension Bundle {
	
	var displayName: String? {
		object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
