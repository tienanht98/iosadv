//
//  ControllDB.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/21/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import Foundation
class ControllDBFolder {
    var id:String?
    var name:String?
    init(id:String,name:String) {
        self.id = id
        self.name = name
    }
  static  func saveFolder(id:String,nameFolder:String,db:OpaquePointer)  {
        FolderUseSQlite.insert(id: id as NSString, nameFolder: nameFolder as NSString, db: db)
    }
  static  func saveFolder(id:String,nameFolder:String)  {
        Folder.save(title: nameFolder, id: id)
    }
    static func Query() ->[ControllDBFolder] {
        var res = [ControllDBFolder]()
        let db = Folder.fetch()
        for i in 0..<db.count {
            res.append(ControllDBFolder(id: db[i].id!, name: db[i].title!))
        }
        return res
    }
    static func Query(db:OpaquePointer) ->[ControllDBFolder] {
         let db =  FolderUseSQlite.query(db: db)
        var res = [ControllDBFolder]()
        for i in 0..<db.count {
            res.append(ControllDBFolder(id: db[i].id!, name: db[i].name!))
        }
        return res
    }
    
}
