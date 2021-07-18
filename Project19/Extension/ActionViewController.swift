//
//  ActionViewController.swift
//  Extension
//
//  Created by Joe Pham on 2021-07-15.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

	@IBOutlet var scriptTextView: UITextView!
	private var pageTitle			= ""
	private var pageURL				= ""
	
	private let defaults 			= UserDefaults.standard
	private var savedScriptByURL	= [String: String]()
	private let savedScriptByURLKey = "SavedScriptByURLKey"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureLeftBarButtonItem() // challenge 1, 2
		configureRightBarButtonItem()
		configureCommunication()
		addKeyboardObservers()
	}

    @IBAction func done() {
		DispatchQueue.global().async { [weak self] in
			guard let self = self else { return }
			self.saveScript(for: self.pageURL) // challenge 2
		}
		
		let item						= NSExtensionItem()
		let argument: NSDictionary		= ["customJavaScript": scriptTextView.text!]
		let webDictionary: NSDictionary	= [NSExtensionJavaScriptFinalizeArgumentKey: argument]
		let customJavaScript			= NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
		item.attachments				= [customJavaScript]
		
		extensionContext?.completeRequest(returningItems: [item], completionHandler: nil)
    }
}


extension ActionViewController {
	private func configureRightBarButtonItem() {
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
		navigationItem.rightBarButtonItem = doneButton
	}
	
	
	private func configureCommunication() {
		if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
			if let itemProvider = inputItem.attachments?.first {
				itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] dict, error in
					guard let itemDictionary = dict as? NSDictionary else { return }
					guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
					self?.pageTitle = javaScriptValues["title"] as? String ?? ""
					self?.pageURL	= javaScriptValues["URL"] as? String ?? ""
					
					self?.restoreSavedScript(for: self!.pageURL) // challenge 2
				}
			}
		}
	}
	
	
	private func addKeyboardObservers() {
		let notification = NotificationCenter.default
		notification.addObserver(self, selector: #selector(adjustTextViewForKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
		notification.addObserver(self, selector: #selector(adjustTextViewForKeyboard), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
	}
	
	@objc
	private func adjustTextViewForKeyboard(notification: Notification) {
		guard let keyboardValue 	= notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
		let keyboardScreenEndFrame 	= keyboardValue.cgRectValue
		let keyboardViewEndFrame 	= view.convert(keyboardScreenEndFrame, from: view.window)
		
		if notification.name == UIResponder.keyboardWillHideNotification {
			scriptTextView.contentInset = .zero
		}
		else {
			scriptTextView.contentInset = UIEdgeInsets(top: 0,
													   left: 0,
													   bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom,
													   right: 0)
		}
		scriptTextView.scrollIndicatorInsets = scriptTextView.contentInset
		
		let selectedRage = scriptTextView.selectedRange
		scriptTextView.scrollRangeToVisible(selectedRage)
	}
}


// for the challenges
extension ActionViewController {
	// challenge 1
	private func configureLeftBarButtonItem() {
		let leftBarButtonItem = UIBarButtonItem(image: SFSymbols.text, style: .plain, target: self, action: #selector(didTapLeftBarButton))
		navigationItem.leftBarButtonItem = leftBarButtonItem
	}
	
	
	@objc
	private func didTapLeftBarButton() {
		let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		ac.popoverPresentationController?.barButtonItem = navigationItem.leftBarButtonItem
		
		let examplesAction = UIAlertAction(title: AlertContext.examples.title, style: .default) { [weak self] _ in
			self?.didTapExamples() // challenge 1
		}
		ac.addAction(examplesAction)
		ac.addAction(UIAlertAction(title: AlertContext.cancel.title, style: .cancel))
		present(ac, animated: true)
	}
	
	
	private func didTapExamples() {
		let ac = UIAlertController(title: AlertContext.examples.title, message: AlertContext.examples.message, preferredStyle: .actionSheet)
		for script in JSExamples {
			ac.addAction(UIAlertAction(title: script.title, style: .default) { [weak self] _ in
				self?.scriptTextView.text = script.code
			})
		}
		ac.addAction(UIAlertAction(title: AlertContext.cancel.title, style: .cancel))
		present(ac, animated: true)
	}
	
	
	// challenge 2
	private func saveScript(for urlString: String) {
		guard let url 			= URL(string: urlString),
			  let host 			= url.host
		else { return }
		savedScriptByURL[host]	= scriptTextView.text
		defaults.set(savedScriptByURL, forKey: savedScriptByURLKey)
	}
	
	
	// challenge 2
	private func restoreSavedScript(for pageURL: String) {
		DispatchQueue.global().async { [weak self] in
			guard let self = self,
				  let restored = self.defaults.object(forKey: self.savedScriptByURLKey) as? [String: String]
			else { return }
			self.savedScriptByURL = restored
			
			if let url = URL(string: pageURL), let host = url.host {
				DispatchQueue.main.async { self.scriptTextView.text = self.savedScriptByURL[host] }
			}
		}
	}
}
