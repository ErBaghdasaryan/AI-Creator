//
//  BaseRouter.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 16.01.25.
//

import UIKit
import Combine
import AICreatorViewModel

class BaseRouter {

    class func popViewController(in navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
