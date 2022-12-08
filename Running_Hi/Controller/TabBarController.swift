//
//  TabBarController.swift
//  Running_Hi
//
//  Created by 황원상 on 2022/12/08.
//

import UIKit

class TabBarController:UITabBarController{
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewContoller()
    }
    
    //MARK: - Helpers
    
    func configureViewContoller(){
        self.delegate = self
        
        let feed = templateNavigationContoller(unselectedImage: UIImage(named: "temp")!, selectedImage: UIImage(named: "temp")!, rootViewController: FeedController())
        let search = templateNavigationContoller(unselectedImage: UIImage(named: "temp")!, selectedImage: UIImage(named: "temp")!, rootViewController: SearchController())
        let photo = templateNavigationContoller(unselectedImage: UIImage(named: "temp")!, selectedImage: UIImage(named: "temp")!, rootViewController: PhotoContoller())
        let profile = templateNavigationContoller(unselectedImage: UIImage(named: "temp")!, selectedImage: UIImage(named: "temp")!, rootViewController: ProfileController())
        
        viewControllers = [feed, search, photo, profile]
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    func templateNavigationContoller(unselectedImage:UIImage,selectedImage:UIImage,rootViewController:UIViewController)->UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.image = unselectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
}

// 포스팅 시 사진을 찍을 수 있게

//MARK: - UITabBarControllerDelegate
extension TabBarController:UITabBarControllerDelegate{
    
}
