//
//  FoodsViewController.swift
//  Foodies
//
//  Created by Chan Jing Hong on 30/08/2017.
//  Copyright © 2017 Cocoacode. All rights reserved.
//

import UIKit

class FoodsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddFoodViewControllerDelegate {

    @IBOutlet weak var foodsTableView: UITableView!

    let foodsController = FoodsController.sharedInstance
    var foods: [Food] = []

    // When the view has finished loading.
    // Do all your setup here
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set tableview datasource and delegate
        foodsTableView.dataSource = self
        foodsTableView.delegate = self

        // Retrieve foods from foodsController
        foods = foodsController.retrieveFoods()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        foodsTableView.reloadData()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        if let addFoodVC = storyboard?.instantiateViewController(withIdentifier: "addFoodVc") as? AddFoodViewController {
            addFoodVC.delegate = self
            present(addFoodVC, animated: true, completion: nil)
        }
    }

    // MARK: - Tableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)

        // Cell's title
        cell.textLabel?.text = foods[indexPath.row].name

        // Detail text label (Subtitle)
        let date = foods[indexPath.row].dateAdded
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mmaa, d MMM yyyy"
        let dateString = dateFormatter.string(from: date)

        cell.detailTextLabel?.text = dateString

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let addFoodVC = storyboard?.instantiateViewController(withIdentifier: "addFoodVc") as? AddFoodViewController {
            addFoodVC.delegate = self
            addFoodVC.food = foods[indexPath.row]
            present(addFoodVC, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            // Remove food, reload tableview data
            foods.remove(at: indexPath.row)
            tableView.reloadData()
//            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Add food view controller delegates
    func didModifiedFood() {
        foodsController.saveFoods(foods)
    }

    func didAddedNewFood(_ food: Food) {
        foods.append(food)
        foodsController.saveFoods(foods)
    }

}
