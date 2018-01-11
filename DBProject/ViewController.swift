//
//  ViewController.swift
//  DBProject
//
//  Created by Vera on 12/30/17.
//  Copyright © 2017 Vera. All rights reserved.
//

import UIKit
import SQLite3
class ViewController: UIViewController {
    var db : OpaquePointer?
    var items = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("LocalDB.db")
        print(fileUrl)
        print(fileUrl.path)
        print(fileUrl.absoluteString)
        print(fileUrl.absoluteURL )
        if  sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("error to open db")
        }
       let crateTableQuarey = "CREATE TABLE India(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTEGER)"
        if sqlite3_exec(db, crateTableQuarey, nil, nil, nil) != SQLITE_OK{
            print("error crate table ")
        }
        //let queryStatementString = "SELECT * FROM india;"
        let queryString = "SELECT * FROM india"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let age = sqlite3_column_int(stmt, 2)
            print(name)
            print(age)
            print(id)
            
            //items.append(Hero(id: Int(id), name: String(describing: name), powerRanking: Int(powerrank)))
        }
    }
}





