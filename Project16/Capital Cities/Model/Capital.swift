//
//  Capital.swift
//  Capital Cities
//
//  Created by Joe Pham on 2021-05-21.
//

import MapKit

class Capital: NSObject, MKAnnotation {
	internal var title: String?
	internal var coordinate: CLLocationCoordinate2D
	internal var info: String
	internal var url: String // challenge 3
	
	init(title: String, coordinate: CLLocationCoordinate2D, info: String, wikiUrl: String) {
		self.title = title
		self.coordinate = coordinate
		self.info = info
		self.url = wikiUrl
	}
}

extension Capital {
	static var identifier = "Capital"
	
	static var mockData: [Capital] = [
		Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics", wikiUrl: "https://en.wikipedia.org/wiki/London"),
		Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago", wikiUrl: "https://en.wikipedia.org/wiki/Oslo"),
		Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light", wikiUrl: "https://en.wikipedia.org/wiki/Paris"),
		Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it", wikiUrl: "https://en.wikipedia.org/wiki/Rome"),
		Capital(title: "Washington, D.C.", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself", wikiUrl: "https://en.wikipedia.org/wiki/Washington,_D.C.")
	]
}
