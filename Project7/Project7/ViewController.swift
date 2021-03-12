//
//  ViewController.swift
//  Project7
//
//  Created by Joe Pham on 2021-01-17.
//

import UIKit

class ViewController: UITableViewController {
    
    // An array to store Petition instances defined in Petition.swift
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Right bar button to show credit
        let infoButton = UIImage(systemName: "info.circle")
        let infoBarButtonItem = UIBarButtonItem(image: infoButton, style: .plain, target: self, action: #selector(creditTapped))
        // Right bar button to refresh the tab view
        let refreshButton = UIImage(systemName: "arrow.clockwise.circle")
        let refreshBarButtonItem = UIBarButtonItem(image: refreshButton, style: .plain, target: self, action: #selector(refreshView))
        
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(promptForPetitionSearch))
             
        navigationItem.rightBarButtonItems = [infoBarButtonItem, refreshBarButtonItem]
        navigationItem.leftBarButtonItems = [searchBarButtonItem]
        
        // Enable large title of this view controller
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Change title of tab view accordingly
        if navigationController?.tabBarItem.tag == 0 {
            title = "Recent Petitions"
        } else {
            title = "Popular Petitions"
        }
        
        // Download JSON data in the background
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        // Show error alert if data is downloaded and parsed
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            // Parse the converted JSON results content into array "petitions"
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            // Tell tableView to reload itself
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    // Method to refresh the table view w/o downloading & parsing data again
    @objc func refreshView() {
        // Reassign all value of the petitions array to filteredPetitions
        filteredPetitions = petitions
        // Reset title
        if navigationController?.tabBarItem.tag == 0 {
            title = "Recent Petitions"
        } else {
            title = "Popular Petitions"
        }
        // Shake up table view
        tableView.reloadData()
    }
    
    // Method to alert users when data doesn't work properly
    @objc func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was an unexpected issue loading the petitions feed. Please check your connection and try again later.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    // Method to show credit upon tapping the right bar button
    @objc func creditTapped() {
        let ac = UIAlertController(title: "Petitions Information", message: "Details of these petitions are provided by We The People API of the White House at api.whitehouse.gov", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    // Method to search for a specific petition upon tapping the left bar button
    @objc func promptForPetitionSearch() {
        let ac = UIAlertController(title: "Search Petition List", message: "Type a topic or petition ID that you would like to filter out", preferredStyle: .alert)
        ac.addTextField()
        
        let searchPetition = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] (action) in
            guard let topic = ac?.textFields?[0].text else { return }
            
            // Searching in the background
            DispatchQueue.global().async {
                self?.searchPetition(topic)
            }
        }
        ac.addAction(searchPetition)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    func searchPetition(_ topic: String) {
        // Declare possible search cases
        let topic = topic.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        // Use filter closure to loop through the petitions array for the topic
        filteredPetitions = petitions.filter {
            $0.title.lowercased().contains(topic) ||
            $0.body.lowercased().contains(topic) ||
            $0.id.contains(topic)
        }
        
        // Shift UI change to main thread
        DispatchQueue.main.async {
            // Change title to topic string
            self.title = "\"\(topic)\""
            // Shake up the table view
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    // Link DetailViewController screen to current ViewController
    // without the need to add the screen in IB or via instantiation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
