//
//  database.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/20/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import Foundation
import SQLite3
struct database {
    init() {
        let db = database.openDatabase()
         database.createTable(db: db!)
    }
    static  func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Note.sqlite") // tạo đường dẫn và tên db
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
        let createTableFolder = """
                                        CREATE TABLE Forlder(
                                        Id CHAR(255) PRIMARY KEY NOT NULL,
                                        Name CHAR(255));
                                        """ // câu lệnh tạo bảng của sql (id kiểu Int làm khoá chính ko đc null , name kiểu char )
        let createTableNote = """
                                        CREATE TABLE Note(
                                        Id TEXT PRIMARY KEY NOT NULL,
                                        IdFolder CHAR(255)   NOT NULL,
                                        Content TEXT);
                                        """
        var createTableStatement: OpaquePointer? = nil
        // 2
        if sqlite3_prepare_v2(db, createTableFolder, -1, &createTableStatement, nil) == SQLITE_OK {
            // 3
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Forlder table created.")
            } else {
                print("Forlder table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        // 4
        sqlite3_finalize(createTableStatement)
        var createTableStatementnote: OpaquePointer? = nil
        // 2
        if sqlite3_prepare_v2(db, createTableNote, -1, &createTableStatementnote, nil) == SQLITE_OK {
            // 3
            if sqlite3_step(createTableStatementnote) == SQLITE_DONE {
                print("Note table created.")
            } else {
                print("Note table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        // 4
        sqlite3_finalize(createTableStatementnote)
    }
}
