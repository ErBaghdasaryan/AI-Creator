//
//  ServiceAssembly.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 16.01.25.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import AICreatorViewModel

public final class ServiceAssembly: Assembly {

    public init() {}

    public func assemble(container: Container) {
        container.autoregister(IKeychainService.self, initializer: KeychainService.init)
        container.autoregister(IAppStorageService.self, initializer: AppStorageService.init)
    }
}
