//
//  CoreDataMN.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/21/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class FolderObj {
    public var title: String?
    public var id: String?
    init(title: String,id: String) {
        self.id = id
        self.title = title
    }
}

class CoreDataMN:saveAbleProtocol  {
    func query() -> [FolderObj] {
        var res = [FolderObj]()
        let db = Folder.fetch()
        for i in 0..<db.count {
            res.append(FolderObj(title: db[i].title!, id: db[i].id!))
        }
        return res
    }
    
    func save( folders: FolderObj) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Folder",
                                                    in: managedContext)!
            let folder = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            folder.setValue(folders.title, forKeyPath: "title")
            folder.setValue(folders.id, forKeyPath: "id")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        
   }
}
