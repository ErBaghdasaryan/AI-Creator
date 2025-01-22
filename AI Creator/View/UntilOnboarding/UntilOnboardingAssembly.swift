//
//  UntilOnboardingAssembly.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 16.01.25.
//

import Foundation
import AICreatorModel
import AICreatorViewModel
import Swinject
import SwinjectAutoregistration

final class UntilOnboardingAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IUntilOnboardingViewModel.self, initializer: UntilOnboardingViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IUntilOnboardingService.self, initializer: UntilOnboardingService.init)
    }
}
