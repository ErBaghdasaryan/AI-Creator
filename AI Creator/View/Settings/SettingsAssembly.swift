//
//  SettingsAssembly.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 28.01.25.
//

import Foundation
import AICreatorViewModel
import Swinject
import SwinjectAutoregistration

final class SettingsAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(ISettingsViewModel.self, initializer: SettingsViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ISettingsService.self, initializer: SettingsService.init)
    }
}
