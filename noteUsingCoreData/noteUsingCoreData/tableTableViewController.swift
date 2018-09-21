//
//  tableTableViewController.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/12/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import UIKit
import CoreData

class tableTableViewController: UITableViewController {
    @IBOutlet var tableview: UITableView!
    var arrFolder = [FolderObj]()
    var i = 0
    var index = 0
    let db = DBFactory.selectDB(type:typeDB.SQL)
    @IBAction func btnAddFolder(_ sender: Any) {
        let alert = UIAlertController(title: "Thư mục mới", message: "Nhập tên cho thư mục này", preferredStyle: .alert)
        alert.addTextField { (textField1:UITextField) in
            textField1.placeholder = "Tên Folder"
            textField1.keyboardAppearance = .dark
            textField1.textAlignment = .center
            textField1.layer.cornerRadius = 15
        }
        let okAction = UIAlertAction(title: "Lưu", style: .default, handler: ({ (ACTION) in
            //let newEntry = FolderMO(conteguard let textField = alert.textFields?.first,
            let id = UUID().uuidString
            let fol = FolderObj(title: alert.textFields![0].text!, id: id )
//            Folder.save(title: alert.textFields![0].text!, id: id)
//            FolderUseSQlite.insert( id: id as NSString, nameFolder: alert.textFields![0].text! as NSString, db: self.db!)
            ControllDBFolder.saveFolder(id: id, nameFolder: alert.textFields![0].text!)
            self.db.save(folders: fol)
            self.arrFolder.append(fol)
            self.tableview.reloadData()
        }))
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The Note"
       arrFolder = self.db.query()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem =  self.editButtonItem
       // self.navigationItem.rightBarButtonItem = UIBarButtonSystemItem.add
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFolder.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellFolder
//        let content = arrfolder[indexPath.row]
 
//          cell.lbNameFolder.text = content.value(forKey: "title") as? String
        cell.lbNameFolder.text = arrFolder[indexPath.row].title
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrFolder.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

          }
    }
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let second = segue.destination as! ViewControllerNote
        
        second.title = arrFolder[index].title
        second.id = arrFolder[index].id
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
