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
		return MapTypes(rawValue: mapTypeSegmentControl.selectedSegmentIndex) ?? .map
	} // challenge 2
	
	override func viewDidLoad() {
		super.viewDidLoad()
		mapView.delegate = self // no need to Control-drag in IB
		DispatchQueue.global().async { [unowned self] in
			self.mapView.addAnnotations(Capital.mockData)
		}
	}
	
	// challenge 2
	@IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
		Utils.hapticOnUIElements()
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
		let wikiAction = UIAlertAction(title: "Wikipedia",
									   style: .default,
									   handler: { [weak self] _ in
										self?.browseWikipedia(
											about: capital.title!,
											with: capital.url!)
									   })
		ac.addAction(wikiAction) // challenge 3
		ac.addAction(UIAlertAction(title: "Close",
								   style: .default))
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
	fileprivate func browseWikipedia(about capital: String, with url: URL?) {
		guard let vc = storyboard?.instantiateViewController(withIdentifier: WebViewController.identifier) as? WebViewController else { return }
		guard url != nil else { return }
		vc.websiteUrl = url
		vc.title = capital
		navigationController?.pushViewController(vc, animated: true)
	}
}