//
//  Note.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import Foundation

struct Note: Codable, Hashable {
	var title: String
	var content: String?
}


extension Note {
	
	static func new() -> Note {
		let now		= Date()
		let title	= "Note at \(now.convertToHourMinuteFormat())"
		return Note(title: title, content: nil)
	}
	
	static var mockData: [Note] = [
		Note(title: "Employee Number", content: "123-456-7890"),
		Note(title: "Mailbox Number", content: "At intersection, middle one, number 10"),
		Note(title: "Tomorrow Forecast", content: "Sunny with hi of 27, lo of 19. AQI averages at 4 - Moderate Health Risk"),
		Note(title: "Word of the Day", content: "Defray - provide money to pay (a cost or expense)")
	]
}
