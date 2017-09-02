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
// Extending from Codable allows us to convert this food to JSON data,
// and as well as converting from JSON data back to a Food Object
class Food {

    /*
     Our food model will contain:
         - Name
         - Description
         - Image
     */
    
    // Properties
    var name: String
    var description: String

    // Initializer
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }

    // Init from a dictionary
    init?(dict: [String : Any]) {
        let name = dict["name"] as? String
        let desc = dict["description"] as? String

        // If either name or description is nil, the init should fail.
        if name == nil || desc == nil {
            return nil
        } else {
            self.name = name!
            self.description = desc!
        }
    }

    func toDict() -> [String : Any] {
        return [
            "name" : self.name,
            "description" : self.description
        ]
    }
}
