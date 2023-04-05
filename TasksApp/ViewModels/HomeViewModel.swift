//
//  HomeViewModel.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import Foundation
import RealmSwift

protocol HomeViewModelTaskListDelegate {
    func reloadTaskList()
}

protocol HomeViewModelSearchListDelegate {
    func reloadSearchTaskList()
}

class HomeViewModel {
    
    private let networkManager = NetworkManager()
    
    var oauth: Oauth?
    var tasks: [Task] = []
    var realmTaskList = [Task]()
    var realmTask = try! Realm()
    var realmManager = RealmManager()
    var delegate1 : HomeViewModelTaskListDelegate?
    var delegate2 : HomeViewModelSearchListDelegate?
    
    func fetchTask(completion: @escaping (Result<[Task], NetworkError>) -> Void) {
        
        networkManager.performRequest(request: Taskrequest.task, completion: completion)
        
    }
    
    func getTasks() {
        networkManager.requestAuth { [self] result in
            switch result {
            case .success(let response):
                self.oauth = response.oauth ?? nil
                ServiceConstants.AuthConstants.accessTokenValue = oauth?.accessToken ?? ""
                ServiceConstants.AuthConstants.refreshTokenValue = oauth?.refreshToken ?? ""
                ServiceConstants.AuthConstants.tokenTypeValue = oauth?.tokenType ?? ""
                ServiceConstants.AuthConstants.expiresInValue = String(oauth?.expiresIn ?? 0)
                self.fetchTask { task in
                    switch task {
                    case .success(let response):
                        self.tasks = response
                        DispatchQueue.main.async {
                            self.delegate1?.reloadTaskList()
                            self.delegate2?.reloadSearchTaskList()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }


    func realmSaveTaskList(taskList: [Task]) {
        realmManager.saveTasks(taskList: taskList)
    }
    
    func realmDeleteTaskList() {
        realmManager.deleteTasks()
    }
    
    func realmReadTaskList() -> [Task]{
        let readTasks = realmManager.readTasks()
        return readTasks
    }
}

