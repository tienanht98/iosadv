//
//  protocol.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/21/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import Foundation

protocol saveAbleProtocol {
    func save(folders:FolderObj )
    func query() -> [FolderObj] 
   
}
