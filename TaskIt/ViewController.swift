//
//  ViewController.swift
//  TaskIt
//
//  Created by David Pirih on 24.09.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let mObjContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchedResultsController = getFetchedResulsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

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
            
            let taskDetailViewController: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            taskDetailViewController.detailedTaskModel = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
        } else if segue.identifier == "toAddTaskSegue" {
            let addTaskViewController = segue.destinationViewController as AddTaskViewController
        }
        
    }

    // MARK: TableView DataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as TaskCell

        let taskModel = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        cell.taskLabel?.text = taskModel.task
        cell.descriptionLabel?.text = taskModel.subTask
        cell.dateLabel?.text = Date.stringFromDate(taskModel.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if fetchedResultsController.sections?.count == 1 {
            let fetchedObjects = fetchedResultsController.fetchedObjects!
            let testTask:TaskModel = fetchedObjects[0] as TaskModel
            if testTask.isCompleted == true {
                return "Completed"
            }
            else {
                return "ToDo's"
            }
            
        }
        else {
            if section == 0 {
                return "ToDo's"
            }
            else  {
                return "Completed"
            }
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let selectedTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if selectedTask.isCompleted == true {
            selectedTask.isCompleted = false
        }
        else {
            selectedTask.isCompleted = true
        }
        
        appDelegate.saveContext()
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // MARK: TableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toTaskDetailSegue", sender: self)
    }
    
    // MARK: Helper Functions
    
    func getFetchedResulsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: mObjContext!, sectionNameKeyPath: "isCompleted", cacheName: nil)
        return fetchedResultsController
    }
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "isCompleted", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, dateSortDescriptor]
        return fetchRequest
    }
}

