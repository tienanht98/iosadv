//
//  Note+CoreDataProperties.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/13/18.
//  Copyright © 2018 iAnh. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var content: String?
    @NSManaged public var folder: Folder?
    static func save(content: String,id :String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let date = Date()
        let entity = NSEntityDescription.entity(forEntityName: "Note",
                                                in: managedContext)!
        let uuid = UUID().uuidString
        let note = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        note.setValue(content, forKeyPath: "content")
        note.setValue(date , forKeyPath: "date")
        note.setValue(id, forKeyPath: "idFolder")
        note.setValue(uuid, forKey: "idNote")
        do {
            try managedContext.save()
            print("save success")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    static func fetch() -> [Note] {
        //1
        var res = [Note]()
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext =
            appDelegate?.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        //3
        do {
            res = try managedContext?.fetch(fetchRequest) as! [Note]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return res
    }
    static func del(index : Int) {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            managedContext.delete(results[index])
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    static func del(idFolder:String) {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                if result.value(forKey: "idFolder") as! String == idFolder {
                    managedContext.delete(result)
                }
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func update(idNote:String,content:String) ->Bool {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        //3
        do {
            let results = try managedContext.fetch(fetchRequest)
            for result in results {
                if result.value(forKey: "idNote") as! String == idNote {
                    result.setValue(content, forKey: "content")
                    try managedContext.save()
                    return true
                }
            }
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return false
    }
    
}
