//
//  note.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/20/18.
//  Copyright © 2018 iAnh. All rights reserved.
//
import Foundation
import SQLite3
class noteUseSQL {
    var id:String?
    var idFolder:String?
    var content:String?
    init(id:String,idFolder:String,content:String) {
        self.id = id
        self.idFolder = idFolder
        self.content = content
    }
    static func insert( id:NSString,idFolder: NSString,content:NSString,db:OpaquePointer) {
        var insertStatement: OpaquePointer? = nil
        let insertStatementString = "INSERT INTO Note (Id, IdFolder,Content) VALUES (?, ?,?);"
        
        
        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            // 2
            sqlite3_bind_text(insertStatement, 1, id.utf8String, -1, nil)
            
            // 3
            sqlite3_bind_text(insertStatement, 2, idFolder.utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, content.utf8String, -1, nil)
            
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
    static func query(db:OpaquePointer)->[noteUseSQL] {
        var res = [noteUseSQL]()
        var queryStatement: OpaquePointer? = nil
        // 1
        let queryStatementString = "SELECT * FROM Note;"
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // 2
            print("Query Result:")
            while(sqlite3_step(queryStatement) == SQLITE_ROW){
                let id = String(cString: sqlite3_column_text(queryStatement, 0))
                let idfolder = String(cString: sqlite3_column_text(queryStatement, 1))
                let content = String(cString: sqlite3_column_text(queryStatement, 2))
                res.append(noteUseSQL(id: id, idFolder: content, content: content))
                print("\(id) | \(idfolder)|\(content)")
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
    static func update(db:OpaquePointer,idupdate:Int32,name:NSString) {
        let updateStatementString = "UPDATE Forlder SET Name = '\(name)' WHERE Id = \(idupdate);"
        
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("UPDATE statement could not be prepared")
        }
        sqlite3_finalize(updateStatement)
    }}
