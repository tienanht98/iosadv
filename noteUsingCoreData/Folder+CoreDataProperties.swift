//
//  Folder+CoreDataProperties.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/12/18.
//  Copyright © 2018 iAnh. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String?
    static func save(title: String,id:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Folder",
                                                in: managedContext)!
        let folder = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        folder.setValue(title, forKeyPath: "title")
        folder.setValue(id, forKeyPath: "id")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    static func del(index : Int) {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =  appDelegate.persistentContainer.viewContext
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Folder")
    
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            managedContext.delete(results[index])
            Note.del(idFolder: results[index].value(forKey: "id") as! String )
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    static func fetch() -> [Folder] {
        
        var res = [Folder]()
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        //2
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "Folder")
        //3
        do {
            res = try managedContext?.fetch(fetchRequest) as! [Folder]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return res
    }
}
