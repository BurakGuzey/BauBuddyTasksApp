//
//  ViewController.swift
//  TasksApp
//
//  Created by Burak Güzey on 5.04.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = TaskListViewController()
        let vc2 = SearchListViewController()
        let vc3 = QRScanViewController()
        
        vc1.title = ServiceConstants.TabBarConstants.vc1
        vc2.title = ServiceConstants.TabBarConstants.vc2
        vc3.title = ServiceConstants.TabBarConstants.vc3
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.tabBarItem = UITabBarItem(title: ServiceConstants.TabBarConstants.vc1,
                                       image: UIImage(systemName: ServiceConstants.TabBarConstants.vc1ImageName), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: ServiceConstants.TabBarConstants.vc2,
                                       image: UIImage(systemName: ServiceConstants.TabBarConstants.vc2ImageName), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: ServiceConstants.TabBarConstants.vc3,
                                       image: UIImage(systemName: ServiceConstants.TabBarConstants.vc3ImageName), tag: 1)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }

}

