//
//  Petition.swift
//  Project7
//
//  Created by Joe Pham on 2021-01-18.
//

import Foundation

// Custom struct to store each petition from JSON
struct Petition: Codable {
    // These are 3 properties avail in the JSON petition filestruct 
    var title: String
    var body: String
    var signatureCount: Int
    var signaturesNeeded: Int
    var signatureThreshold: Int
    var status: String
    var url: String
    var id: String
}
