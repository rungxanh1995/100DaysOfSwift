//
//  Global.swift
//  Project4
//
//  Created by Joe Pham on 2021-01-11.
//

import Foundation

// Properties/methods in Global.swift is accessible in other Swift files of this app bundle

class Website {
    var globalWebsitesList: [String]
    init(globalWebsitesList: [String]) {
        self.globalWebsitesList = globalWebsitesList
    }
}

let websiteInstance = Website(globalWebsitesList: ["apple.com", "hackingwithswift.com", "georgebrown.ca"])
