//
//  ContentVC.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import UIKit

class ContentVC: UIViewController {
	
	var noteContentView: UITextView!
	
	private var note: Note!
	private var delegate: ListVCDelegate!
	private var isNewNote: Bool!
	init(note: Note, delegate: ListVCDelegate, isNewNote: Bool) {
		super.init(nibName: nil, bundle: nil)
		self.note		= note
		self.title		= note.title
		self.delegate	= delegate
		self.isNewNote	= isNewNote
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor	= .systemBackground
		
		configureNoteContentView()
		configureToolbarItems()
		addKeyboardObservers()
    }
	
	
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		guard isNewNote else { return }
		note.title		= title!
		note.content	= noteContentView.text
				
		PersistenceManager.updateWith(note: note, actionType: .add) { [weak self] error in
			guard let self = self else { return }
			guard let error = error else {
				DispatchQueue.main.async {
					let listVC = ListVC()
					listVC.notes.insert(self.note, at: 0)
				}
				return
			}
			self.presentAlertOnMainThread(title: Messages.somethingWrong, message: error.rawValue, buttonTitle: "Ok")
		}
	}

	
	@objc
	func didTapComposeButton() {
		isNewNote									= true
		noteContentView.text						= ""
		noteContentView.isUserInteractionEnabled	= true
		title										= Note.new().title
	}
	
	
	@objc
	func didTapDeleteButton() {
		delegate.didTapDeleteButton(for: note)
		navigationController?.popViewController(animated: true)
	}
}


extension ContentVC {
	
	private func pushListVC() {
		noteContentView.resignFirstResponder()
		let listVC      = ListVC()
		navigationController?.pushViewController(listVC, animated: true)
	}
	
	
	private func configureNoteContentView() {
		noteContentView								= UITextView(frame: view.bounds)
		noteContentView.text						= note.content
		noteContentView.font						= UIFont.preferredFont(forTextStyle: .body)
		noteContentView.backgroundColor				= .systemBackground
		noteContentView.returnKeyType				= .done
		noteContentView.keyboardDismissMode 		= .interactive
		noteContentView.autocorrectionType			= .default
		noteContentView.isUserInteractionEnabled	= isNewNote
		view.addSubview(noteContentView)
	}
	
	
	private func configureToolbarItems() {
		let spacer			= UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let composeButton	= UIBarButtonItem(image: Images.note, style: .plain, target: self, action: #selector(didTapComposeButton))
		let deleteButton	= UIBarButtonItem(image: Images.trash, style: .plain, target: self, action: #selector(didTapDeleteButton))
		let toolbarItems	= isNewNote ? [spacer, composeButton] : [deleteButton, spacer, composeButton]
		setToolbarItems(toolbarItems, animated: true)
		navigationController?.isToolbarHidden = false
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
			noteContentView.contentInset = .zero
		}
		else {
			noteContentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
		}
		noteContentView.scrollIndicatorInsets = noteContentView.contentInset
		
		let selectedRage = noteContentView.selectedRange
		noteContentView.scrollRangeToVisible(selectedRage)
	}
}
