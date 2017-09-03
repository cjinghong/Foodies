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

class AddFoodViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!

    var food: Food?
    weak var delegate: AddFoodViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Make image view to have a rounded corner
        foodImageView.layer.cornerRadius = 10

        // Set the image, name, and description for that food
        foodImageView.image = food?.image ?? UIImage(named: "placeholder")
        foodTextField.text = food?.name ?? ""
        foodTextField.delegate = self

        if let date = food?.dateAdded {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mmaa, d/mm/yy"
            let dateString = dateFormatter.string(from: date)
            dateLabel.text = "Added on: \(dateString)"
        } else {
            dateLabel.text = ""
        }
    }

    @IBAction func addImageTapped(_ sender: Any) {
        // Show photos library
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        self.present(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        if let food = food {
            // If a food already exist, modify it.
            food.name = foodTextField.text ?? ""
            food.image = foodImageView.image
            delegate?.didModifiedFood()
        } else {
            // If a food doesn't already exist, 
            // create a new food with the properties from the textfield and textview
            let newFood = Food(name: foodTextField.text ?? "",
                               dateAdded: Date(),
                               image: foodImageView.image)

            // Informs delegate that a new food has been added
            delegate?.didAddedNewFood(newFood)
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(false)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(false)
        return true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            foodImageView.image = selectedImage
        }
        self.dismiss(animated: true, completion: nil)
    }

}
