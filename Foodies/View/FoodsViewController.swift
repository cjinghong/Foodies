//
//  FoodsViewController.swift
//  Foodies
//
//  Created by Chan Jing Hong on 30/08/2017.
//  Copyright © 2017 Cocoacode. All rights reserved.
//

import UIKit

class FoodsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var foodsTableView: UITableView!

    let foods: [String] = [
        "Tom Yam",
        "Spaghetti",
        "Nasi Lemak",
        "KFC",
        "Satay"
    ]

    // When the view has finished loading.
    // Do all your setup here
    override func viewDidLoad() {
        super.viewDidLoad()

        foodsTableView.dataSource = self
        let controller = FoodsController.sharedInstance
    }

    @IBAction func addFoodTapped(_ sender: Any) {
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)

        // Cell's title
        cell.textLabel?.text = foods[indexPath.row]

        // Detail text label (Subtitle)
        cell.detailTextLabel?.text = "Its a food!"

        return cell
    }


}
