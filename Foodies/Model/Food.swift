//
//  Food.swift
//  Foodies
//
//  Created by Chan Jing Hong on 01/09/2017.
//  Copyright © 2017 Cocoacode. All rights reserved.
//
import Foundation
import UIKit

// Our food model, contains all the properties that a food should have.
// Needs to be a subclass of NSObject, and implements NSCoding
// in order to archive the object into a data file.
class Food: NSObject, NSCoding {

    class PropertyKey {
        static let name = "name"
        static let image = "image"
        static let dateAdded = "dateAdded"
    }
    
    // Properties
    var name: String
    var dateAdded: Date
    var image: UIImage?

    // Initializer
    init(name: String, dateAdded: Date, image: UIImage? = nil) {
        self.name = name
        self.dateAdded = dateAdded
        self.image = image
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(dateAdded, forKey: PropertyKey.dateAdded)
        aCoder.encode(image, forKey: PropertyKey.image)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let dateAdded = aDecoder.decodeObject(forKey: PropertyKey.dateAdded) as? Date
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage

        // If any one of the values is nil, the init will fail
        if name == nil || dateAdded == nil {
            return nil
        }
        self.init(name: name!, dateAdded: dateAdded!, image: image)
    }

}
