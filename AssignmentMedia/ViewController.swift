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
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        
        let secondVC = UINavigationController(rootViewController: SearchViewController())
        secondVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let thridVC = UINavigationController(rootViewController: ProfileViewController())
        thridVC.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        
        self.viewControllers = [firstVC, secondVC, thridVC]
    }

}

