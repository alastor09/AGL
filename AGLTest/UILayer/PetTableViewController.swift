//
//  PetTableViewController.swift
//  AGLTest
//
//  Created by Soan Saini on 15/2/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import UIKit

class PetTableViewController: UITableViewController {
    let cellReuseIdentifier = "reuseIdentifier"
    
    var groupedCats: [GenderType: [Pet]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var manager : PeopleViewModel?

    override func viewWillAppear(_ animated: Bool) {
        manager = PeopleViewModel()
        manager?.FetchPeopleFeed(completionHandler:{
            (result) in
            switch result
            {
            case .response(let data):
                self.groupedCats.removeAll()
                self.groupedCats = data
                self.tableView.reloadData()
                break
            case .error(error: _):
                self.groupedCats.removeAll()
                let alert = UIAlertController(title: "Error", message: "Error Retreiving Data", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                break
            }
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.groupedCats.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.groupedCats[(Array(self.groupedCats.keys)[section])]?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let pets = self.groupedCats[Array(self.groupedCats.keys)[indexPath.section]]
        cell.textLabel?.text = pets![indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (Array(self.groupedCats.keys)[section]).rawValue.uppercased()
    }
}
