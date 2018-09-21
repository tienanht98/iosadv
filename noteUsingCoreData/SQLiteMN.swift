//
//  SQLiteMN.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/21/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import Foundation
import SQLite
class SQLiteMN: saveAbleProtocol {
   
    let db = database.openDatabase()
    func query() -> [FolderObj] {
        
        let db = FolderUseSQlite.query(db: self.db!)
        var res = [FolderObj]()
        for i in 0..<db.count {
            res.append(FolderObj(title: db[i].name!, id: db[i].id!))
        }
        return res
    }
    
    func save(folders: FolderObj) {
            
            var insertStatement: OpaquePointer? = nil
            let insertStatementString = "INSERT INTO Forlder (Id, Name) VALUES (?, ?);"
        
            
            // 1
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                
                // 2
                sqlite3_bind_text(insertStatement, 1, folders.id, -1, nil)
                
                // 3
                sqlite3_bind_text(insertStatement, 2, folders.title, -1, nil)
                
                // 4
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
            // 5
            sqlite3_finalize(insertStatement)
        
    }
    
    
}
