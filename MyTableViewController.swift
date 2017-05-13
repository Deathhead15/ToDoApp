//
//  MyTableViewController.swift
//  ToDo_RodelasTolentino
//
//  Created by Roderick Rodelas on 2017-03-29.
//  Copyright © 2017 Roderick Rodelas. All rights reserved.
//

import UIKit
import CoreData

class MyTableViewCell: UITableViewCell{

    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
}


class MyTableViewController: UITableViewController {
    


    var appDelegate: AppDelegate!
    var manageContext: NSManagedObjectContext!
    var tasks:[Task] = []
    var selectedName:String?
    var selectedDate:Date?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func setContext(){
        if appDelegate==nil{
            self.appDelegate = UIApplication.shared.delegate as? AppDelegate
            self.manageContext = appDelegate.persistentContainer.viewContext
        }
    }
    
    func readData(){
        
        do{
            tasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("Fetch Failed")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell

        let task = tasks[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_CA")
        
        let date = dateFormatter.string(from: task.date! as Date)
        
        cell.taskLabel?.text = task.name
        cell.dateLabel?.text = date
        return cell
        
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
                tasks = try context.fetch(Task.fetchRequest())
            } catch {
                print("Fetch Failed")
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let task = tasks[indexPath.row]
        selectedName = task.name
        selectedDate = task.date! as Date
        
        performSegue(withIdentifier: "editSegue", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editSegue"{
            
        let editTask = segue.destination as! EditViewController
        let path = tableView.indexPathForSelectedRow
        editTask.index = path?.row
        editTask.editName = selectedName
        editTask.editDateNew = selectedDate

        }
        
        
    }
    

}
