//
//  Bundle+Ext.swift
//  Core Graphics
//
//  Created by Joe Pham on 2021-08-20.
//

import Foundation


extension Bundle {
	
	var displayName: String? {
		object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
