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

    // File directory to save our foods
    var foodFileUrl: URL {
        get {
            let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let foodUrl = documentsDir?.appendingPathComponent("foods")
            return foodUrl!
        }
    }

    // FoodsController is a Singleton
    public static let sharedInstance = FoodsController()

    // Empty private init
    private init() {

    }

    // MARK: - Saving and retrieving food
    func saveFoods(_ foods: [Food]) {
        let successfullySaved = NSKeyedArchiver.archiveRootObject(foods, toFile: foodFileUrl.path)
        if successfullySaved {
            print("Successfully saved food to \(foodFileUrl.path)")
        } else {
            print("Failed to save food")
        }
    }

    /// Retrieve all the foods from our food file
    func retrieveFoods() -> [Food] {
        // Unarchive foods from file, and if it doesnt exist, returns an empty array
        let foods = NSKeyedUnarchiver.unarchiveObject(withFile: foodFileUrl.path) as? [Food]
        return foods ?? []
    }

}
