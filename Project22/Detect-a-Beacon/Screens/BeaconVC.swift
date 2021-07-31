//
//  BeaconVC.swift
//  Detect-a-Beacon
//
//  Created by Joe Pham on 2021-07-27.
//

import UIKit
import CoreLocation

class BeaconVC: UIViewController {
	
	// MARK: Properties
	private var distanceReadingLabel: UILabel!
	private var circleView: UIView!				// challenge 3
	private var locationManager: CLLocationManager?
	
	
	private var beaconList: [Beacon]	= Beacon.mockData
	private var isBeaconFirstDetected	= true	// challenge 1
	
	private var currentBeaconUUID: UUID?		// challenge 2
	
	
	// MARK: ViewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureLocationManager()
		configureCircleView()
		configureDistanceReadingLabel()
		
		configureViewUI(distanceType: .unknown, for: "No Beacon")
	}
}


// MARK: Logic
extension BeaconVC: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse || status == .authorizedAlways {
			if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
				if CLLocationManager.isRangingAvailable() {
					startScanning()
				}
			}
		}
	}
	
	
	func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
		if let beacon = beacons.first {
			
			// challenge 2
			if currentBeaconUUID == nil { currentBeaconUUID = beaconConstraint.uuid }
			
			guard currentBeaconUUID == beaconConstraint.uuid else { return }
			
			let beaconName = "Beacon \(String(beaconConstraint.uuid.uuidString).prefix(8))" // enough UUID info to differentiate names
			configureViewUI(distanceType: beacon.proximity, for: beaconName)
			showFirstDetected(for: beaconName) // challenge 1
		}
		else {
			guard currentBeaconUUID == beaconConstraint.uuid else { return }
			currentBeaconUUID = nil
			configureViewUI(distanceType: .unknown, for: "Unknown Beacon")
		}
	}
}


extension BeaconVC {

	// challenge 1
	private func showFirstDetected(for beaconName: String) {
		if isBeaconFirstDetected {
			isBeaconFirstDetected = false // flip back to false
			presentAlertOnMainThread(title: "Beacon Detected", message: "\(beaconName) was found within the vicinity", buttonTitle: "Ok")
		}
	}
	
	
	private func startScanning() {
		for beacon in beaconList {
			addBeaconRegion(uuidString: beacon.uuidString, major: beacon.major, minor: beacon.minor, id: beacon.name)
		}
	}
	
	
	private func addBeaconRegion(uuidString: UUID, major: CLBeaconMajorValue, minor: CLBeaconMinorValue, id: String) {
		let beaconRegion = CLBeaconRegion(uuid: uuidString, major: major, minor: minor, identifier: id)
		locationManager?.startMonitoring(for: beaconRegion)
		locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
	}
	
	private func configureLocationManager() {
		locationManager				= CLLocationManager()
		locationManager?.delegate	= self
		locationManager?.requestAlwaysAuthorization()
	}
	
	
	// MARK: UI updates
	
	// challenge 2
	private func configureViewUI(distanceType: CLProximity, for name: String) {
		title = name
		
		UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: []) { [weak self] in
			guard let self = self else { return }

			switch distanceType {
			case .far:
				self.view.backgroundColor 		= .systemOrange
				self.circleView.transform		= CGAffineTransform(scaleX: 0.50, y: 0.50) // challenge 3
				self.distanceReadingLabel.text 	= DistanceLabelText.far
			case .near:
				self.view.backgroundColor 		= .systemBlue
				self.circleView.transform		= CGAffineTransform(scaleX: 0.75, y: 0.75) // challenge 3
				self.distanceReadingLabel.text 	= DistanceLabelText.near
			case .immediate:
				self.view.backgroundColor 		= .systemGreen
				self.circleView.transform		= CGAffineTransform(scaleX: 1.00, y: 1.00) // challenge 3
				self.distanceReadingLabel.text 	= DistanceLabelText.immediate
			default:
				self.view.backgroundColor 		= .systemGray
				self.circleView.transform		= CGAffineTransform(scaleX: 0.001, y: 0.001) // challenge 3
				self.distanceReadingLabel.text 	= DistanceLabelText.unknown
			}
		}
	}
}


// MARK: UI configs
extension BeaconVC {
	
	private func configureCircleView() {

		let size: CGFloat = (DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed) ? 256 : 320
		
		circleView						= UIView(frame: .zero)
		circleView.backgroundColor		= .secondarySystemBackground
		circleView.alpha				= 0.5
		circleView.layer.cornerRadius	= size / 2
		circleView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(circleView)
		
		NSLayoutConstraint.activate([
			circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			circleView.heightAnchor.constraint(equalToConstant: size),
			circleView.widthAnchor.constraint(equalToConstant: size)
		])
	}
	
	
	private func configureDistanceReadingLabel() {
		distanceReadingLabel			= UILabel(frame: .zero)
		distanceReadingLabel.text 		= DistanceLabelText.unknown
		distanceReadingLabel.font 		= UIFont.systemFont(ofSize: 40, weight: .thin)
		distanceReadingLabel.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(distanceReadingLabel)
		
		NSLayoutConstraint.activate([
			distanceReadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			distanceReadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
			distanceReadingLabel.heightAnchor.constraint(equalToConstant: 100)
		])
	}
}
