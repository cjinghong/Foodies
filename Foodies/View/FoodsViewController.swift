//
//  FoodsViewController.swift
//  Foodies
//
//  Created by Chan Jing Hong on 30/08/2017.
//  Copyright © 2017 Cocoacode. All rights reserved.
//

import UIKit

class FoodsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var foodsTableView: UITableView!

    let foodsController = FoodsController.sharedInstance

    // When the view has finished loading.
    // Do all your setup here
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set tableview datasource and delegate
        foodsTableView.dataSource = self
        foodsTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        foodsTableView.reloadData()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        if let addFoodVC = storyboard?.instantiateViewController(withIdentifier: "addFoodVc") as? AddFoodViewController {
            present(addFoodVC, animated: true, completion: nil)
        }
    }

    // MARK: - Tableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodsController.foods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)

        let food = foodsController.foods[indexPath.row]

        // Cell's title
        cell.textLabel?.text = food.name

        // Detail text label (Subtitle)
        let date = food.dateAdded
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mmaa, d MMM yyyy"
        let dateString = dateFormatter.string(from: date)

        cell.detailTextLabel?.text = dateString

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let addFoodVC = storyboard?.instantiateViewController(withIdentifier: "addFoodVc") as? AddFoodViewController {
            let food = foodsController.foods[indexPath.row]
            addFoodVC.food = food
            present(addFoodVC, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            // Remove food, reload tableview data
            let food = foodsController.foods[indexPath.row]
            foodsController.delete(food)
            tableView.reloadData()
        }
    }

}
