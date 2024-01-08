//
//  EduTaskerTabBarController.swift
//  EduTasker
//
//  Created by Gabriel Campos on 7/1/24.
//

import UIKit

class EduTaskerTabBarController: UITabBarController {
    lazy var gradeTabBarItem: UITabBarItem = {
        let tabItem = UITabBarItem(title: "Notas", image: UIImage(systemName: "text.badge.checkmark"), tag: 0)
        return tabItem
    }()
    
    lazy var profileTabBarItem: UITabBarItem = {
        let tabItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 0)
        return tabItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let gradeViewController = GradeViewController()
        gradeViewController.tabBarItem = gradeTabBarItem
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = profileTabBarItem
        
        self.viewControllers =  [gradeViewController, profileViewController]
    }
    
}
