

import Foundation
import UIKit

//MARK: - SPACING AND INDENTATION CAN BE BETTER
class TabBarController: UITabBarController {
    let tabOne:UIViewController = {
        let tabOne = HomeScreenView()
        let tabOneBarItem = CustomTabBarItem(icon: "magnifyingglass").TabBarItem
        tabOne.tabBarItem = tabOneBarItem
        return tabOne
    }()
    
    let tabTwo: UIViewController = {
        let tabTwo = LocationViewController()
        let tabTwoBarItem2 = CustomTabBarItem(icon: "location.circle").TabBarItem
        tabTwo.tabBarItem = tabTwoBarItem2
        return tabTwo
    }()
    
    let tabThree: UIViewController = {
        let tabThree=HeadlinesViewController()
        let tabThreeBarItem = CustomTabBarItem(icon: "newspaper.circle").TabBarItem
        tabThree.tabBarItem = tabThreeBarItem
        return tabThree
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.backgroundColor=UIColor.white
        self.viewControllers = [tabOne,tabTwo,tabThree]
    }
}

class CustomTabBarItem{
    var icon:String?
    let TabBarItem = UITabBarItem()
    
    init(icon:String) {
        TabBarItem.image = UIImage(systemName: icon)?.withTintColor(.black,renderingMode: .alwaysOriginal)
        TabBarItem.selectedImage = UIImage(systemName: icon)?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    }
}
