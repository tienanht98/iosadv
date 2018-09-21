//
//  ViewControllerNote.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/13/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import UIKit
import CoreData
class ViewControllerNote: UIViewController {
    var id:String!
    var arrNote:[NSManagedObject] = []
    var index = 0
    @IBOutlet weak var tableview: UITableView!
    @IBAction func btAddNote(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "toContent") as? ContentVC
        vc?.id = self.id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     var title: String?
        tableview.delegate = self
        tableview.dataSource = self
        arrNote = Note.fetch()
        print(id)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        arrNote = Note.fetch()
        tableview.reloadData()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ViewControllerNote : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        for note in arrNote {
            if note.value(forKey: "idFolder") as? String == id {
                count = count + 1
            }
        }
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellNote") as! CellNote
        let content = arrNote[indexPath.row]
        cell.lbTitle.text = content.value(forKey: "content") as? String
        return cell
    }
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrNote.remove(at: indexPath.row)
            Note.del(index: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "toContent") as? ContentVC
        let content = arrNote[indexPath.row]
        vc?.text = content.value(forKey: "content") as? String
        vc?.idNote = (content.value(forKey: "idNote") as? String)!
        vc?.id = id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
