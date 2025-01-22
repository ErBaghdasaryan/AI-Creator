//
//  EffectsAssembly.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import Foundation
import AICreatorViewModel
import Swinject
import SwinjectAutoregistration

final class EffectsAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEffectsViewModel.self, initializer: EffectsViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IEffectsService.self, initializer: EffectsService.init)
    }
}
