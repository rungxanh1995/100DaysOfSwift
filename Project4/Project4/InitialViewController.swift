//
//  InitialViewController.swift
//  Project4
//
//  Created by Joe Pham on 2021-01-11.
//

import UIKit
import WebKit

// Create an initial screen with a list of website for users to choose
class InitialViewController: UITableViewController {
    var websites = websiteInstance.globalWebsitesList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Title of the initial screen
        title = "Easy Browser"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // Set what and how to display each table cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    // Set number of rows in initial screen
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Instantiate ViewController by typecasting as ViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebsiteView") as? ViewController {
            // Set selectedWebsite value
            vc.selectedWebsite = websites[indexPath.row]
            // Then push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // End of class
}
