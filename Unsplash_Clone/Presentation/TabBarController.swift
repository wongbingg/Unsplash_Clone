//
//  TabBarController.swift
//  Unsplash_Clone
//
//  Created by 이원빈 on 2023/04/14.
//

import UIKit

final class TabBarController: UITabBarController {
    private let homeVC = HomeViewController()
    private let searchVC = SearchViewController()
    private let submitVC = SubmitViewController()
    private let mypageVC = MyPageViewController()
    
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()        
        setupTabBar()
    }
    
    private func setupTabBar() {
        homeVC.tabBarItem.image = UIImage(systemName: "photo")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        submitVC.tabBarItem.image = UIImage(systemName: "plus.square.fill")
        mypageVC.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
        
        let homeNavCon = UINavigationController(rootViewController: homeVC)
        let searchNavCon = UINavigationController(rootViewController: searchVC)
        let submitNavCon = UINavigationController(rootViewController: submitVC)
        let mypageNavCon = UINavigationController(rootViewController: mypageVC)
        
        setViewControllers([homeNavCon, searchNavCon, submitNavCon, mypageNavCon], animated: true)
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .black
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct TabBarController_Preview: PreviewProvider {
    static var previews: some View {
        TabBarController().showPreview()
    }
}
#endif
