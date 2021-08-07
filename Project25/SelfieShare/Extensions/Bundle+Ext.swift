//
//  Bundle+Ext.swift
//  SelfieShare
//
//  Created by Joe Pham on 2021-08-06.
//

import Foundation

extension Bundle {
	var displayName: String? {
		object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
