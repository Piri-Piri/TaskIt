//
//  ViewController.swift
//  TaskIt
//
//  Created by David Pirih on 24.09.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let task1 = TaskModel(task: "Learn Swift", subTask: "Bitfountain Course", date: Date.from(2014, month: 12, day: 12))
        let task2 = TaskModel(task: "Build a own App", subTask: "Publish to AppStore", date: Date.from(2015, month: 12, day: 12))
        let task3 = TaskModel(task: "Gym", subTask: "Leg Day", date: Date.from(2014, month: 10, day: 12))
        
        taskArray = [task1, task2, task3]
        
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBAction Functions
    
    @IBAction func addTaskAction(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("toAddTaskSegue", sender: self)
    }

    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toTaskDetailSegue" {
            let indexPath = tableView.indexPathForSelectedRow()
        
            var taskDetailViewController = segue.destinationViewController as TaskDetailViewController
            taskDetailViewController.detailedTaskModel = taskArray[indexPath!.row]
            taskDetailViewController.mainVC = self
        } else if segue.identifier == "toAddTaskSegue" {
            var addTaskViewController = segue.destinationViewController as AddTaskViewController
            addTaskViewController.mainVC = self
        }
        
    }

    // MARK: TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as TaskCell

        let taskModel = taskArray[indexPath.row]
        
        cell.taskLabel?.text = taskModel.task
        cell.descriptionLabel?.text = taskModel.subTask
        cell.dateLabel?.text = Date.stringFromDate(taskModel.date)
        
        return cell
    }
    
    // MARK: TableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toTaskDetailSegue", sender: self)
    }
}

