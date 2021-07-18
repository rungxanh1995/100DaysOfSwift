//
//  JavaScript+Examples.swift
//  Extension
//
//  Created by Joe Pham on 2021-07-18.
//

import Foundation


struct Scripts: Codable {
	let title: String
	let code: String
}


let script1 = Scripts(title: "Website Title", code: "alert(document.title);")
let script2 = Scripts(title: "Website URL", code: "alert(document.URL);")
let script3 = Scripts(title: "Replace Content", code: "document.write('Hello, World!');")
let script4 = Scripts(title: "Number of Cookies", code: "alert(`${document.cookie.length} cookies saved by this website`);")
let JSExamples = [script1, script2, script3, script4]
