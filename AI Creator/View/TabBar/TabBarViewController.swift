//
//  TabBarViewController.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import UIKit
import AICreatorViewModel
import SnapKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        lazy var generatorViewController = self.createNavigation(title: "Generator",
                                                                 image: "generator",
                                                                 vc: ViewControllerFactory.makeGeneratorViewController())

        lazy var effectsViewController = self.createNavigation(title: "Effects",
                                                               image: "effects",
                                                               vc: ViewControllerFactory.makeEffectsViewController())

        lazy var videosViewController = self.createNavigation(title: "My Videos",
                                                              image: "videos",
                                                              vc: ViewControllerFactory.makeVideosViewController())

        self.setViewControllers([generatorViewController, effectsViewController, videosViewController], animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(setCurrentPageToTeam), name: Notification.Name("ResetCompleted"), object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setCurrentPageToTeam),
            name: NSNotification.Name("UpdateDataNotification"),
            object: nil
        )

        generatorViewController.delegate = self
        effectsViewController.delegate = self
        videosViewController.delegate = self
    }

    @objc func setCurrentPageToTeam() {
        self.selectedIndex = 2
    }

    private func createNavigation(title: String, image: String, vc: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        self.tabBar.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        self.tabBar.barTintColor = UIColor.black

        let unselectedImage = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: image)?.withTintColor(UIColor(hex: "#EEA272")!, renderingMode: .alwaysTemplate)

        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage

        navigation.tabBarItem.title = title

        let nonselectedTitleColor: UIColor = UIColor.white.withAlphaComponent(0.5)
        let selectedTitleColor: UIColor = UIColor(hex: "#EEA272")!

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: nonselectedTitleColor
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedTitleColor
        ]

        navigation.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        navigation.tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)

        return navigation
    }

    // MARK: - Deinit
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        #endif
    }
}

//MARK: Navigation & TabBar Hidden
extension TabBarViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            self.tabBar.isHidden = true
        } else {
            self.tabBar.isHidden = false
        }
    }
}

//MARK: Preview
import SwiftUI

struct TabBarViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let tabBarViewController = TabBarViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) -> TabBarViewController {
            return tabBarViewController
        }

        func updateUIViewController(_ uiViewController: TabBarViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) {
        }
    }
}
