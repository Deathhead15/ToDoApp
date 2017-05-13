//
//  ViewController.swift
//  ToDo_RodelasTolentino
//
//  Created by Roderick Rodelas on 2017-03-29.
//  Copyright © 2017 Roderick Rodelas. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var btnAdd: UIBarButtonItem!
    
    @IBOutlet weak var taskField: UITextField!
    
    @IBOutlet weak var dateField: UIDatePicker!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func btnAddTask(_ sender: Any) {
        
        let taskName = taskField.text
        
        if (taskName?.isEmpty)!{
        }else {
        
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
            let task = Task(context: context)
        
            task.name = taskField.text!
            task.date = dateField.date as NSDate
            
            //Saving
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
            
            
            navigationController?.popViewController(animated: true)
        }
    }

}

