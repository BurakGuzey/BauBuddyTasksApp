//
//  RealmManager.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import Foundation
import RealmSwift

struct RealmManager {
    
    let realm = try! Realm()
    
    func saveTasks(taskList: [Task]) {
        
        do {
            try realm.write {
                for taskItem in taskList {
                    let itemToSave = TaskRealm()
                    itemToSave.task = taskItem.task
                    itemToSave.title = taskItem.title
                    itemToSave.descriptionOfTask = taskItem.description
                    itemToSave.colorCode = taskItem.colorCode
                    realm.add(itemToSave)
                }
            }
        } catch {
            print("Realm couldn't add the data")
        }
    }
    
    func deleteTasks() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Realm couldn't delete the data")
        }
    }
    
    func readTasks() -> [Task] {
        let realmTasksSaved = self.realm.objects(TaskRealm.self)
        var tasksSaved = [Task]()
            for tasktoSave in realmTasksSaved {
                var taskSaved = Task(task: tasktoSave.task,
                                    title: tasktoSave.title,
                                    description: tasktoSave.descriptionOfTask,
                                    colorCode: tasktoSave.colorCode)
                tasksSaved.append(taskSaved)
                }
        return tasksSaved
    }
}

