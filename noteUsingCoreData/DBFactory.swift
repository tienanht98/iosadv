//
//  DBFactory.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/21/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import Foundation
enum typeDB {
    case SQL,CoreData
    }

class DBFactory {
    static func selectDB(type:typeDB) ->saveAbleProtocol //
    {
        switch type { // SQLite or Core Data
        case .SQL:
            return  SQLiteMN()
        case .CoreData:
            return  CoreDataMN()
        
    }
    }
    
}

