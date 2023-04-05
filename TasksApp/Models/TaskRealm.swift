//
//  TaskRealm.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import Foundation
import RealmSwift

class TaskRealm: Object {
    
    @objc dynamic var task: String?
    @objc dynamic var title: String?
    @objc dynamic var descriptionOfTask: String?
    @objc dynamic var colorCode: String?
    
}
