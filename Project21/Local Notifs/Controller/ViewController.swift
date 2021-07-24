//
//  ViewController.swift
//  Local Notifs
//
//  Created by Joe Pham on 2021-07-23.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
	
	private var notifCenter = UNUserNotificationCenter.current()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		configureRegisterBarButtonItem()
		configureScheduleBarButtonItem()
	}

	
	@objc
	func registerLocalNotifications() {
		notifCenter.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
			print(granted ? "Granted permission 😙!" : "Notif permission denied 😢!")
		}
	}
	
	
	@objc
	func scheduleLocalNotifications(seconds: TimeInterval) {
		registerNotificationCategories()
		notifCenter.removeAllPendingNotificationRequests()
		
		// content: what to show
		let content 				= UNMutableNotificationContent()
		content.title 				= "Late wake up call"
		content.body 				= "The early bird catches the worm, but the second mouse gets the cheese."
		content.categoryIdentifier 	= UNIdentifier.alarm
		content.userInfo 			= ["customData": "fizzbuzz"]
		content.sound			 	= UNNotificationSound(named: UNNotificationSoundName(rawValue: FileNames.ringtone)) // bonus
		
		// trigger: when to show
		var dateComponents 			= DateComponents()
		dateComponents.hour 		= 10
		dateComponents.minute		= 30
		let trigger1				= UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
		let trigger2				= UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
		let trigger3				= UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false) // challenge 2
		
		// request: trigger & content
		let request1 				= UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger1)
		let request2 				= UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger2)
		let request3 				= UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger3)
		let notifRequests			= [request1, request2, request3]  // challenge 2
		notifRequests.forEach { request in notifCenter.add(request) }
	}
}


extension ViewController: UNUserNotificationCenterDelegate {
	
	func registerNotificationCategories() {
		notifCenter.delegate = self
		
		let showAction = UNNotificationAction(identifier: UNIdentifier.show, title: "Tell me more...", options: .foreground)
		let remindAction = UNNotificationAction(identifier: UNIdentifier.remind, title: "Remind me later", options: .foreground) // challenge 2
		
		let category = UNNotificationCategory(identifier: UNIdentifier.alarm, actions: [showAction, remindAction], intentIdentifiers: [], options: .allowAnnouncement)
		notifCenter.setNotificationCategories([category])
	}
	
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		
		let userInfo = response.notification.request.content.userInfo
		
		if let customData = userInfo["customData"] as? String { print("Saved custom data: \(customData).") }
		
		switch response.actionIdentifier {
		case UNNotificationDefaultActionIdentifier:
			presentAlert(title: "Default identifier", message: "User swiped notifitication on the lockscreen") // challenge 1
		case UNIdentifier.show:
			presentAlert(title: "Custom Show identifier", message: "User swiped down notification and tapped button") // challenge 1
		case UNIdentifier.remind:
			presentAlert(title: "Custom Reminder identifier", message: "You will get a notification this time tomorrow")
			scheduleLocalNotifications(seconds: 86400) // challenge 2
		default:
			break
		}
		
		completionHandler()
	}
}


extension ViewController {
	
	private func configureRegisterBarButtonItem() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: BarButtonTitle.register, style: .plain, target: self, action: #selector(registerLocalNotifications))
	}
	
	private func configureScheduleBarButtonItem() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: BarButtonTitle.schedule, style: .plain, target: self, action: #selector(scheduleLocalNotifications))
	}
}
