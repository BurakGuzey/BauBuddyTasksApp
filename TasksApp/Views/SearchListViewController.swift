//
//  SearchListViewController.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import UIKit

class SearchListViewController: UIViewController, HomeViewModelSearchListDelegate {
    
    let homeViewModel = HomeViewModel()
    var textOnSearchBar = String()
    var searchResults: [Task] = []
    let EmptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 21))
    
    private var searchBar = UISearchBar()
    private let searchTableView: UITableView = {
        let searchTableView = UITableView()
        searchTableView.register(TaskListTableViewCell.self, forCellReuseIdentifier: TaskListTableViewCell.identifier)
        return searchTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        homeViewModel.delegate2 = self
        searchBar.delegate = self
        
        view.addSubview(searchTableView)
        view.addSubview(searchBar)
        searchBar.placeholder = "Search"
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            
            searchTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            searchTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
        EmptyLabel.center = CGPoint(x: 200, y: 450)
        EmptyLabel.textAlignment = .center
        EmptyLabel.text = "Search to view task"
        
        self.view.addSubview(EmptyLabel)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.searchTextField.keyboardType = .emailAddress
        searchBar.searchTextField.becomeFirstResponder()
        
    }
    
    func reloadSearchTaskList() {
        updateSearchResults(for: searchBar)
        self.searchTableView.reloadData()
    }
}
extension SearchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskListTableViewCell.identifier, for: indexPath) as! TaskListTableViewCell
        cell.configure(task: searchResults[indexPath.row])
        return cell
    }
    
}

extension SearchListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text {
            
            EmptyLabel.isHidden = true
            searchTableView.isHidden = false
            
            textOnSearchBar = text
            
            searchedTasks(text: text)
            searchTableView.reloadData()
            
            searchBar.searchTextField.resignFirstResponder()
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            searchTableView.isHidden = true
            EmptyLabel.isHidden = false
            
        }
    }
    
    func searchedTasks(text: String) {
        homeViewModel.getTasks()
    }
    
    func filterContentForSearchText(_ textOnSearchBar: String) {
        searchResults = homeViewModel.tasks.filter({ (task:Task) -> Bool in
            let titleMatch = task.title!.range(of: textOnSearchBar, options: NSString.CompareOptions.caseInsensitive)
            let taskMatch = task.task!.range(of: textOnSearchBar, options: NSString.CompareOptions.caseInsensitive)
            let descriptionMatch = task.description!.range(of: textOnSearchBar, options: NSString.CompareOptions.caseInsensitive)
            return titleMatch != nil || taskMatch != nil || descriptionMatch != nil}
        )
    }
        
        func updateSearchResults(for searchBar: UISearchBar) {
            if let searchText = searchBar.text {
                filterContentForSearchText(searchText)
                searchTableView.reloadData()
            }
        }
    }
