//
//  GeneratorRouter.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import UIKit
import AICreatorViewModel

final class GeneratorRouter: BaseRouter {

    static func showPaymentViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makePaymentViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
