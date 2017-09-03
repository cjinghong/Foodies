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


    private(set) var foods: [Food] = []

    // Empty private init
    private init() {
        foods = retrieveFoods()
    }

    // MARK: - Add, modify, delete
    func addFood(_ food: Food) {
        foods.append(food)
        save()
    }

    func delete(_ food: Food) {
        if let foodIndex = foods.index(of: food) {
            foods.remove(at: foodIndex)
            save()
        }
    }

    // MARK: - Saving and retrieving food
    func retrieveFoods() -> [Food] {
        // Unarchive foods from file, and if it doesnt exist, returns an empty array
        foods = NSKeyedUnarchiver.unarchiveObject(withFile: foodFileUrl.path) as? [Food] ?? []
        return foods
    }

    func save() {
        let successfullySaved = NSKeyedArchiver.archiveRootObject(foods, toFile: foodFileUrl.path)
        if successfullySaved {
            print("Successfully saved food to \(foodFileUrl.path)")
        } else {
            print("Failed to save food")
        }
    }

}
