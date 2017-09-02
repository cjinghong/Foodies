//
//  FoodsController.swift
//  Foodies
//
//  Created by Chan Jing Hong on 01/09/2017.
//  Copyright © 2017 Cocoacode. All rights reserved.
//

import Foundation

// This is our controller. Think of the controller as a manager
// that manages all the different kinds of food you have.
// Any save, modify, deleting of food will be done through this controller
class FoodsController {
    // File directory
    var foodJsonFileURL: URL {
        get {
            let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let foodUrl = documentsDir?.appendingPathComponent("foods.json")
            return foodUrl!
        }
    }

    // FoodsController is a Singleton
    public static let sharedInstance = FoodsController()

    // Empty private init
    private init() {

    }

    // MARK: - Saving and retrieving food
    /// Save all the given foods to our json file
    func saveFoods(_ foods: [Food]) {

        // Array of dictionaries
        var foodDicts: [[String : Any]] = []
        for food in foods {
            foodDicts.append(food.toDict())
        }

        // Convert the food dictionaries to a Json data, and write it to our foodJsonFileURL
        do {
            let data = try JSONSerialization.data(withJSONObject: foodDicts, options: .prettyPrinted)
            print(String(data: data, encoding: .utf8) ?? "")
            try data.write(to: foodJsonFileURL)
        } catch {
            print(error)
        }
    }

    /// Retrieve all the foods from our json file
    func retrieveFoods() -> [Food] {
        do {
            var foods: [Food] = []
            let jsonData = try Data(contentsOf: foodJsonFileURL)
            let foodDicts = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [[String : Any]]

            // Loop through the food dictionaries, and initialize Food objects from them
            for dict in foodDicts {
                if let food = Food(dict: dict) {
                    foods.append(food)
                }
            }
            return foods
        } catch {
            // If anything goes wrong, return an empty array
            print(error)
            return []
        }
    }

}
