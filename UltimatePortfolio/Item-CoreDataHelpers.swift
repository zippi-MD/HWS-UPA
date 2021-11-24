//
//  Item-CoreDataHelpers.swift
//  UltimatePortfolio
//
//  Created by Alejandro Mendoza on 23/11/21.
//

import Foundation

extension Item {
    var itemTitle: String {
        title ?? ""
    }
    
    var itemDetail: String {
        detail ?? ""
    }
    
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    
    static var example: Item {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext
        
        let item = Item(context: viewContext)
        item.title = "Example Title"
        item.detail = "This is an example item"
        item.creationDate = Date()
        
        return item
    }
}
