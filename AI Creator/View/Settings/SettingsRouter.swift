//
//  SettingsRouter.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 28.01.25.
//

import Foundation
import UIKit
import AICreatorViewModel

final class SettingsRouter: BaseRouter {
    static func showPaymentViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makePaymentViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showUsageViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeUsageViewController()
        viewController.navigationItem.hidesBackButton = false
        navigationController.navigationBar.isHidden = false
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: false)
    }
}
