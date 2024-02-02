//
//  ViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.backgroundColor = .black
        self.tabBar.barTintColor = .black
        addVC()
    }

    private func addVC() {
        let firstVC = UINavigationController(rootViewController: HomeViewController())
        firstVC.tabBarItem = UITabBarItem(title: "1", image: UIImage(systemName: "1.circle"), selectedImage: UIImage(systemName: "1.circle"))
        
        let secondVC = UINavigationController(rootViewController: DetailViewController())
        secondVC.tabBarItem = UITabBarItem(title: "2", image: UIImage(systemName: "2.circle"), selectedImage: UIImage(systemName: "2.circle"))
        
        self.viewControllers = [firstVC, secondVC]
    }

}

