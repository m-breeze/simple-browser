//
//  WebList.swift
//  SimpleBrowser
//
//  Created by Marina Khort on 09.08.2020.
//  Copyright © 2020 Marina Khort. All rights reserved.
//

import UIKit

class WebList: UITableViewController {
	var websites = ["apple.com", "hackingwithswift.com", "medium.com", "swiftbook.ru"]

	override func viewDidLoad() {
        super.viewDidLoad()
		title = "Select website"

    }
    
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return websites.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
		cell.textLabel?.text = websites[indexPath.row]
		return cell
	}
   
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let vc = storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController {
			vc.website = websites[indexPath.row]
			navigationController?.pushViewController(vc, animated: true)
		}
	}
}
