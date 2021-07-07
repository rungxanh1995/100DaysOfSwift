//
//  ViewController.swift
//  Capital Cities
//
//  Created by Joe Pham on 2021-05-21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var mapTypeSegmentControl: UISegmentedControl! // challenge 2
	private var mapType: MapTypes {
		MapTypes(rawValue: mapTypeSegmentControl.selectedSegmentIndex) ?? .map
	} // challenge 2
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.delegate = self // no need to Control-drag in IB
		DispatchQueue.global().async { [weak self] in
			guard let self = self else { return }
			self.mapView.addAnnotations(Capital.mockData)
		}
	}
	
	// challenge 2
	@IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
		HapticFeedback.hapticOnUIElements()
		switch mapType {
		case .map:
			mapView.mapType = .standard
		case .hybrid:
			mapView.mapType = .hybrid
		case .satellite:
			mapView.mapType = .satellite
		}
	}
}

extension MapViewController: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard annotation is Capital else { return nil }
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Capital.identifier) as? MKPinAnnotationView
		configureAnnotationView(&annotationView, annotation) // challenge 1
		return annotationView
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		guard let capital = view.annotation as? Capital else { return }
		let ac = UIAlertController(title: capital.title,
								   message: capital.info,
								   preferredStyle: .alert)
		let wikiAction = UIAlertAction(
			title: "Wikipedia",
			style: .default,
			handler: { [weak self] _ in
				guard let self = self else { return }
				self.browseWikipedia(about: capital.title!, with: capital.url)
			})
		let closeAction = UIAlertAction(title: "Close", style: .default)
		
		ac.addAction(wikiAction) // challenge 3
		ac.addAction(closeAction)
		present(ac, animated: true)
	}
}

extension MapViewController {
	fileprivate func configureAnnotationView(_ annotationView: inout MKPinAnnotationView?, _ annotation: MKAnnotation) {
		if annotationView == nil {
			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Capital.identifier)
			annotationView?.canShowCallout = true
			annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
			annotationView?.pinTintColor = .systemPink // challenge 1
		} else {
			annotationView?.annotation = annotation
		}
	}
	
	// challenge 3
	private func browseWikipedia(about capital: String, with url: String) {
		guard let url = URL(string: url) else { return }
		presentSafariVC(with: url)
	}
}
