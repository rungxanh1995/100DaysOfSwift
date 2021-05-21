//
//  ViewController.swift
//  Capital Cities
//
//  Created by Joe Pham on 2021-05-21.
//

import UIKit
import MapKit

class ViewController: UIViewController {
	@IBOutlet weak var mapView: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.delegate = self // no need to Control-drag in IB
		title = "Capital Cities"
		mapView.addAnnotations(Capital.mockData)
	}
}

extension ViewController: MKMapViewDelegate {
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
		ac.addAction(UIAlertAction(title: "OK",
								   style: .default))
		present(ac, animated: true)
	}
}

extension ViewController {
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
}
