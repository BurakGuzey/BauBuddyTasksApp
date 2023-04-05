//
//  TaskListViewController.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, HomeViewModelTaskListDelegate {
    
    let networkManager = NetworkManager()
    let homeViewModel = HomeViewModel()
    
    @objc private let refreshControl = UIRefreshControl()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskListTableViewCell.self, forCellReuseIdentifier: TaskListTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        
        homeViewModel.delegate1 = self
        homeViewModel.getTasks()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        homeViewModel.realmSaveTaskList(taskList: homeViewModel.tasks)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        tableView.reloadData()
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.refreshControl.endRefreshing()
        }
    }
    
    func reloadTaskList() {
        self.tableView.reloadData()
    }
}

extension TaskListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskListTableViewCell.identifier, for: indexPath) as! TaskListTableViewCell
        cell.configure(task: homeViewModel.tasks[indexPath.row])
        return cell
    }
}
