//
//  Setupable.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 16.01.25.
//

import Foundation

protocol ISetupable {
    associatedtype SetupModel
    func setup(with model: SetupModel)
}
