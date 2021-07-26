//
//  PersistenceManager.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import Foundation


enum PersistenceActionType { case add, delete }

enum PersistenceManager {
	static let defaults = UserDefaults.standard
	
	enum Keys { static let savedNotes = "savedNotes" }
	
	static func save(notes: [Note]) -> NAError? {
		do {
			let encoder = JSONEncoder()
			let encoded = try encoder.encode(notes)
			defaults.set(encoded, forKey: Keys.savedNotes)
			return nil
		} catch {
			return .unableToSave
		}
	}
	
	static func retrieveNotes(completed: @escaping (Result<[Note], NAError>) -> Void) {
		guard let savedData = defaults.object(forKey: Keys.savedNotes) as? Data else {
			completed(.success([]))
			return
		}
		do {
			let decoder = JSONDecoder()
			let loaded	= try decoder.decode([Note].self, from: savedData)
			completed(.success(loaded))
		} catch {
			completed(.failure(.unableToLoad))
		}
	}
	
	static func updateWith(note: Note, actionType: PersistenceActionType, completed: @escaping (NAError?) -> Void) {
		retrieveNotes { result in
			switch result {
			
			case .success(var notes):
				switch actionType {
				case .add:
					notes.insert(note, at: 0) // a new note should be first in line
				case .delete:
					notes.removeAll { $0 == note }
				}
				completed(save(notes: notes))
				
			case .failure(let error):
				completed(error)
			}
		}
	}
}
