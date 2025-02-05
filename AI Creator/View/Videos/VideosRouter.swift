//
//  VideosRouter.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import UIKit
import AICreatorViewModel

final class VideosRouter: BaseRouter {

    static func showSettingsViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeSettingsViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}

