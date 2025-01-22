//
//  UntilOnboardingRouter.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 16.01.25.
//

import Foundation
import UIKit
import AICreatorViewModel

final class UntilOnboardingRouter: BaseRouter {

    static func showTabBarViewController(in navigationController: UINavigationController) {
//        let viewController = ViewControllerFactory.makeTabBarViewController()
//        viewController.navigationItem.hidesBackButton = true
//        navigationController.navigationBar.isHidden = true
//        navigationController.pushViewController(viewController, animated: true)
    }

    static func showOnboardingViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeOnboardingViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
