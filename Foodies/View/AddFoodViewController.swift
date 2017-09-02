//
//  AddFoodViewController.swift
//  Foodies
//
//  Created by Chan Jing Hong on 02/09/2017.
//  Copyright © 2017 Cocoacode. All rights reserved.
//

import UIKit

protocol AddFoodViewControllerDelegate: class {
    func didAddedNewFood(_ food: Food)
    func didModifiedFood()
}

class AddFoodViewController: UIViewController {

    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    var food: Food?
    weak var delegate: AddFoodViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the name and description for that food
        foodTextField.text = food?.name ?? ""
        descriptionTextView.text = food?.description ?? ""

        if let date = food?.dateAdded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mmaa, d/mm/yy"
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = "Added on: \(dateString)"
        } else {
            dateLabel.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        if let food = food {
            // If a food already exist, modify it.
            food.name = foodTextField.text ?? ""
            food.description = descriptionTextView.text
            delegate?.didModifiedFood()
        } else {
            // If a food doesn't already exist, 
            // create a new food with the properties from the textfield and textview
            let newFood = Food(name: foodTextField.text ?? "", description: descriptionTextView.text)

            // Informs delegate that a new food has been added
            delegate?.didAddedNewFood(newFood)
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(false)
    }
}
