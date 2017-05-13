//
//  EditViewController.swift
//  ToDo_RodelasTolentino
//
//  Created by Roderick Rodelas on 2017-03-29.
//  Copyright © 2017 Roderick Rodelas. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
    
    @IBOutlet weak var editField: UITextField!
    
    @IBOutlet weak var editDate: UIDatePicker!
    
    var editName:String?
    var editDateNew:Date?
    var tasks:[Task] = []
    var index:Int?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editField.text = editName
        editDate .setDate(editDateNew!, animated: false)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveEdit(_ sender: Any) {
        
        let taskName = editField.text
        
        if (taskName?.isEmpty)!{
        }
        else
        {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            do{
                tasks = try context.fetch(Task.fetchRequest())
            } catch {
                print("Fetch Failed")
            }
            
            let task = tasks[index!]
            task.setValue(editField.text!, forKey: "name")
            task.setValue(editDate.date as NSDate, forKey: "date")
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        }
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
