//
//  Folder.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/20/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import Foundation
import SQLite3
class FolderUseSQlite {
    var id:String?
    var name:String?
    init(id:String,name:String) {
        self.id = id
        self.name = name
    }
    static func insert( id:NSString,nameFolder: NSString,db:OpaquePointer) {
        var insertStatement: OpaquePointer? = nil
        let insertStatementString = "INSERT INTO Forlder (Id, Name) VALUES (?, ?);"
        
        
        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            // 2
            sqlite3_bind_text(insertStatement, 1, id.utf8String, -1, nil)

            // 3
            sqlite3_bind_text(insertStatement, 2, nameFolder.utf8String, -1, nil)
            
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
    
    static func query(db:OpaquePointer)->[FolderUseSQlite] {
        var res = [FolderUseSQlite]()
        var queryStatement: OpaquePointer? = nil
        // 1
        let queryStatementString = "SELECT * FROM Forlder;"
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // 2
            print("Query Result:")
            while(sqlite3_step(queryStatement) == SQLITE_ROW){
                let id = String(cString: sqlite3_column_text(queryStatement, 0))
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                res.append(FolderUseSQlite(id: id, name: name))
                print("\(id) | \(name)")
            }
        }
    return res
   }
    static func delete(db:OpaquePointer,id:Int32) {
        var deleteStatement: OpaquePointer? = nil
        let deleteStatementStirng = "DELETE FROM Forlder WHERE Id = \(id);"
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
