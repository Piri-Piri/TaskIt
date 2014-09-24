//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by David Pirih on 24.09.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import Foundation
import UIKit

class AddTaskViewController: UIViewController {
    
    var mainVC: ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
 
    @IBAction func addTaskAction(sender: UIButton) {
        var task = TaskModel(task: taskTextField.text, subTask: subTaskTextField.text, date: taskDatePicker.date)
        mainVC.taskArray.append(task)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelAction(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}