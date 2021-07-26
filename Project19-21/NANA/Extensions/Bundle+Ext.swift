//
//  Bundle+Ext.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import Foundation


extension Bundle {
	var displayName: String? {
		object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
