//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by David Pirih on 24.09.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
 
    @IBAction func addTaskAction(sender: UIButton) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let mObjContext = appDelegate.managedObjectContext
        
        let entityDesc = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: mObjContext!)
        let task = TaskModel(entity: entityDesc!, insertIntoManagedObjectContext: mObjContext)
        task.task = taskTextField.text
        task.subTask = subTaskTextField.text
        task.date = taskDatePicker.date
        task.isCompleted = false
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        var results:NSArray = mObjContext!.executeFetchRequest(request, error: &error)!
        
        for result in results {
            println("\(result)")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}