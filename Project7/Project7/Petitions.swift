//
//  Petitions.swift
//  Project7
//
//  Created by Joe Pham on 2021-01-18.
//

import Foundation

struct Petitions: Codable {
    // Get JSON parser to load the "results" key of the JSON file first
    // Then inside that load is the array of Petition instances
    var results: [Petition]
}
