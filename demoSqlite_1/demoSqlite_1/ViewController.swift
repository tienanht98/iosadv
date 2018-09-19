//
//  ViewController.swift
//  demoSqlite_1
//
//  Created by Trần Tiến Anh on 9/18/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    var db:OpaquePointer?
    override func viewDidLoad() {
        super.viewDidLoad()
        db =  creatdb.openDatabase()
        creatdb.insert(id: 4, name: "Trần Thị Hương Lan", db: db!)
        creatdb.insert(id: 3, name: "Trần  Hương Lan", db: db!)
        creatdb.query(db: db!)
        creatdb.delete(db: db!)
        creatdb.update(db: db!, idupdate: 4, name: "nhung")
         creatdb.query(db: db!)
                // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
      sqlite3_close(db)
    }

}

