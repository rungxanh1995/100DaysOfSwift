//
//  Person.swift
//  Project10
//
//  Created by Joe Pham on 2021-02-05.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
