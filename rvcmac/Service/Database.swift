//
//  Database.swift
//  rvcmac
//
//  Created by Nikita Titov on 24/09/2017.
//  Copyright © 2017 Ribose. All rights reserved.
//

import Foundation
import CoreData
import CocoaLumberjack

class Database {
    
    let context: NSManagedObjectContext
    
    required init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func selectConnection(name: String) -> Connection? {
        let context = AppDelegate.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Connection> = Connection.fetchRequest()
        let predicate = NSPredicate(format: "name = %@", name)
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        let items = try? context.fetch(fetchRequest)
        let item = items?.first
        if let item = item {
            DDLogInfo("Selected connection=\(item)")
        } else {
            DDLogInfo("Could not selected connection with name=\(name)")
        }
        return item
    }
    
    func insertConnection(name: String) {
        let item = Connection(context: context)
        item.name = name
        item.isSelected = false
        do {
            try context.save()
            DDLogInfo("Inserted connection=\(item)")
        } catch let error {
            DDLogError("Could not insert connection with name=\(name) error=\(error.localizedDescription)")
        }
    }

}
