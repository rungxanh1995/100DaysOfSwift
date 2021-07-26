//
//  ListVC.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import UIKit


protocol ListVCDelegate: AnyObject {
	
	func didTapDeleteButton(for note: Note)
}


class ListVC: UIViewController {
	
	// MARK: Properties
	let tableView			= UITableView(frame: .zero, style: .insetGrouped)
	var notes				= [Note]()
	var noteIndex			= 0
	
	var notesCountBarItem: UIBarButtonItem!
	
	// MARK: Sections
	private enum Section: String { case main = "All Notes" }
	
	private let sectionTitles: [Section] = [.main]
	
	
	// MARK: VC Life Cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewController()
		configureTableView()
		configureToolbarItems()
		
		getSavedNotes()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		getSavedNotes()
	}
	
	
	// MARK: Persistence
	func getSavedNotes() {
		PersistenceManager.retrieveNotes { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let notes):
				self.notes = notes
				self.updateUI(with: notes)
			case .failure(let error):
				self.presentAlertOnMainThread(title: Messages.somethingWrong, message: error.rawValue, buttonTitle: "Ok")
			}
		}
		
		if self.notes.isEmpty { self.showEmptyStateView(with: Messages.noNotes, in: self.view) }
	}
}


// MARK: - TableView Delegate & Data Source

extension ListVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard !(notes.isEmpty) else { return nil }
		return sectionTitles[section].rawValue
	}
	
	func numberOfSections(in tableView: UITableView) -> Int { sectionTitles.count }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.resuseIdentifier, for: indexPath) as? NoteCell
		else { return UITableViewCell() }
		let note = notes[indexPath.row]
		cell.set(for: note)
		return cell
	}
}


extension ListVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		noteIndex		= indexPath.row
		let note		= notes[noteIndex]
		let contentVC	= ContentVC(note: note, delegate: self, isNewNote: false)
		navigationController?.pushViewController(contentVC, animated: true)
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		guard editingStyle == .delete else { return }
		
		PersistenceManager.updateWith(note: notes[indexPath.row], actionType: .delete) { [weak self] error in
			guard let self = self else { return }
			guard error == nil else {
				self.presentAlertOnMainThread(title: Messages.unableToDelete, message: error!.rawValue, buttonTitle: "Ok")
				return
			}
			DispatchQueue.main.async {
				#warning("Bug here: Deleting from list vc causing app termination")
				tableView.deleteRows(at: [indexPath], with: .automatic)
//				self.notes.remove(at: indexPath.row)
				self.updateNotesCount()
				
				if self.notes.isEmpty { self.showEmptyStateView(with: Messages.noNotes, in: self.view) }
			}
		}
	}
}


// MARK: UI Config

extension ListVC {
	
	private func configureViewController() {
		title						= Bundle.main.displayName
		view.backgroundColor		= .systemBackground
		navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	
	private func configureTableView() {
		view.addSubview(tableView)
		tableView.frame				= view.bounds
		tableView.rowHeight			= 68
		tableView.tableFooterView	= UIView(frame: .zero)
		tableView.delegate			= self
		tableView.dataSource		= self
		tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.resuseIdentifier)
	}
	
	
	private func configureToolbarItems() {
		notesCountBarItem	= UIBarButtonItem(title: "\(notes.count) Notes", style: .plain, target: nil, action: nil)
		let spacer		= UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let compose		= UIBarButtonItem(image: Images.note, style: .plain, target: self, action: #selector(didTapComposeButton))
		setToolbarItems([spacer, notesCountBarItem, spacer, compose], animated: true)
		navigationController?.isToolbarHidden = false
	}
	
	
	private func updateUI(with notes: [Note]) {
		DispatchQueue.main.async {
			guard !(notes.isEmpty) else {
				DispatchQueue.main.async {
					self.showEmptyStateView(with: Messages.noNotes, in: self.view)
				}
				return
			}
			
			self.notes = notes
			self.view.bringSubviewToFront(self.tableView)
			self.tableView.reloadData()
			self.updateNotesCount()
		}
	}
	
	private func updateNotesCount() {
		notesCountBarItem.title = "\(notes.count) Notes"
	}
}


// MARK: New Note

extension ListVC {
	
	@objc
	func didTapComposeButton() {
		let newNote = Note.new()
		let contentVC = ContentVC(note: newNote, delegate: self, isNewNote: true)
		navigationController?.pushViewController(contentVC, animated: true)
	}
}


// MARK: Delete Note
extension ListVC: ListVCDelegate {
	
	func didTapDeleteButton(for note: Note) {
		
		let noteToDelete = notes[noteIndex]
		PersistenceManager.updateWith(note: noteToDelete, actionType: .delete) { [weak self] error in
			guard let self = self else { return }
			guard error == nil else {
				self.presentAlertOnMainThread(title: Messages.unableToDelete, message: error!.rawValue, buttonTitle: "Ok")
				return
			}
			DispatchQueue.main.async {
				self.notes.remove(at: self.noteIndex)
				self.tableView.deleteRows(at: [IndexPath(row: self.noteIndex, section: 0)], with: .automatic)
				self.getSavedNotes()
			}
		}
	}
}
