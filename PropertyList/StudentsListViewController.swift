//
//  StudentsListViewController.swift
//  PropertyList
//
//  Created by apple on 19/02/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import UIKit

class StudentsListViewController: UITableViewController {
    
    var appDirectoryPath: String = ""
    var finalPath: String = ""
    var students: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        appDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        preparePathForPlist()
        readStudents()
        print(appDirectoryPath)
    }
    
    func preparePathForPlist() {
        let plistPath = "/Students.plist"
        finalPath = appDirectoryPath + plistPath
        print(finalPath)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return students.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        cell.textLabel?.text = students[indexPath.row]
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func addStudent(_ sender: Any) {
     
        let alertController = UIAlertController(title: "Enter new student", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (userNameTF) in
            
        }
        
        let action = UIAlertAction(title: "Save", style: .default) { (action) in
            let name = alertController.textFields?[0].text ?? "ccc"
            self.saveItInfoPList(newStudent: name)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveItInfoPList(newStudent: String) {
        print(finalPath)
        if FileManager.default.fileExists(atPath: finalPath) {
            var existingStudents = NSArray(contentsOfFile: finalPath)
            existingStudents = existingStudents?.adding(newStudent) as! NSArray
            
            existingStudents?.write(toFile: finalPath, atomically: true)
            students = existingStudents as! [String]
            tableView.reloadData()
        } else {
            var array: NSArray = NSArray()
            array = array.adding(newStudent) as NSArray
            print(array)
            array.write(toFile: finalPath, atomically: true)
            students.append(newStudent)
            tableView.reloadData()
        }
    }
    
    func readStudents() {
        if FileManager.default.fileExists(atPath: finalPath) {
            var existingStudents = NSArray(contentsOfFile: finalPath)
            students = existingStudents as! [String]
            tableView.reloadData()
        }
    }
}
