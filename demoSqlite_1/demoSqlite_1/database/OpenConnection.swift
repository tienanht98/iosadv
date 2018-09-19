//
//  OpenConnection.swift
//  demoSqlite_1
//
//  Created by Trần Tiến Anh on 9/19/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import Foundation
import SQLite3
struct
 creatdb {
    
  static  func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("HeroesDatabase.sqlite") // tạo đường dẫn và tên db
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK { // tạo db nếu có rồi thì mở ra
            print("Successfully opened connection to database at \(fileURL.path)")
            return db
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
        }
        return db
    }
    
  static  func createTable(db:OpaquePointer) {
        // 1
        let createTableString = """
                                        CREATE TABLE Contact(
                                        Id INT PRIMARY KEY NOT NULL,
                                        Name CHAR(255));
                                        """ // câu lệnh tạo bảng của sql (id kiểu Int làm khoá chính ko đc null , name kiểu char )
        var createTableStatement: OpaquePointer? = nil
        // 2
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            // 3
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Contact table created.")
            } else {
                print("Contact table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        // 4
        sqlite3_finalize(createTableStatement)
    }
    
   static func insert(id: Int32, name: NSString,db:OpaquePointer) {
        var insertStatement: OpaquePointer? = nil
        let insertStatementString = "INSERT INTO Contact (Id, Name) VALUES (?, ?);"
        // 1
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
    
            // 2
            sqlite3_bind_int(insertStatement, 1, id)
            // 3
            sqlite3_bind_text(insertStatement, 2, name.utf8String, -1, nil)
            
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
    
    
  static func query(db:OpaquePointer) {
        var queryStatement: OpaquePointer? = nil
        // 1
    let queryStatementString = "SELECT * FROM Contact;"

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            // 2
            print("Query Result:")
            while(sqlite3_step(queryStatement) == SQLITE_ROW){
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(cString: sqlite3_column_text(queryStatement, 1))
                
                print("\(id) | \(name)")
            }
    }
//
//            if sqlite3_step(queryStatement) == SQLITE_ROW {
//                // 3
//
//                let id = sqlite3_column_int(queryStatement, 0)
//                // 4
//                let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
//                let name = String(cString: queryResultCol1!)
//
//                // 5
//                print("Query Result:")
//                print("\(id) | \(name)")
//
//
//            } else {
//                print("Query returned no results")
//            }
//        } else {
//            print("SELECT statement could not be prepared")
//        }
        
        // 6
        sqlite3_finalize(queryStatement)
    }
   static func delete(db:OpaquePointer) {
        var deleteStatement: OpaquePointer? = nil
        let deleteStatementStirng = "DELETE FROM Contact WHERE Id = 2;"
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
        let updateStatementString = "UPDATE Contact SET Name = '\(name)' WHERE Id = \(idupdate);"

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
    }
}
