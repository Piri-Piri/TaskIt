//
//  TaskModel.swift
//  TaskIt
//
//  Created by David Pirih on 25.09.14.
//  Copyright (c) 2014 Piri-Piri. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var task: String
    @NSManaged var subTask: String
    @NSManaged var date: NSDate
    @NSManaged var isCompleted: NSNumber

}
