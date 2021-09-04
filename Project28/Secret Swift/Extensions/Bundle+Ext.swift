//
//  Bundle+Ext.swift
//  Secret Swift
//
//  Created by Joe Pham on 2021-09-02.
//

import Foundation.NSBundle

extension Bundle {
	
	var displayName: String? {
		object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
