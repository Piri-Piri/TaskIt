//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by David Pirih on 24.09.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import Foundation
import UIKit

class TaskDetailViewController: UIViewController {
    
    var detailedTaskModel: TaskModel!
    var mainVC: ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        taskTextField.text = detailedTaskModel.task
        subTaskTextField.text = detailedTaskModel.subTask
        taskDatePicker.date = detailedTaskModel.date
    }
    
    @IBAction func doneAction(sender: UIBarButtonItem) {
        var editedTask = TaskModel(task: taskTextField.text, subTask: subTaskTextField.text, date: taskDatePicker.date)
        mainVC.taskArray[mainVC.tableView.indexPathForSelectedRow()!.row] = editedTask
        self.navigationController?.popViewControllerAnimated(true)
    }
}