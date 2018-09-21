//
//  ContentVC.swift
//  noteUsingCoreData
//
//  Created by Trần Tiến Anh on 9/13/18.
//  Copyright © 2018 iAnh. All rights reserved.
//

import UIKit

class ContentVC: UIViewController , UITextViewDelegate {
    var db = database.openDatabase()
    var id:String!
    var idNote:String = ""
    var text:String! 
    @IBAction func bnSave(_ sender: Any) {
        
//        navigationController?.popViewController(animated: true)
         txtViewContent.resignFirstResponder()
    }
    func textViewDidChange(_ textView: UITextView) {
        //Note.update(idNote: idNote, content: txtViewContent.text)
    }
    @IBOutlet weak var txtViewContent: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(id)")
        
        txtViewContent.text = text
        txtViewContent.delegate = self
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backAction(_ sender: Any) {
        
        print("\(id)")
        noteUseSQL.insert(id: idNote as NSString, idFolder: id! as NSString, content: txtViewContent.text as NSString, db: db!  )
        if Note.update(idNote: idNote, content: txtViewContent.text) == false {
            Note.save(content: txtViewContent.text, id: id)
        }
        
        self.navigationController?.popViewController(animated: true)
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
//extension ContentVC {
//    override func willMove(toParentViewController parent: UIViewController?) {
//        super.willMove(toParentViewController:parent)
//        if parent == self.navigationController?.parent {
//          do {
//            try Note.save(content: txtViewContent.text, id: id)
//        } catch {
//            print(" looi ")
//        }
//
//            // The back button was pressed or interactive gesture used
//        }
//    }
//}
