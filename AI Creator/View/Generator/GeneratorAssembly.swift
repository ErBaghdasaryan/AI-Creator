//
//  GeneratorAssembly.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import Foundation
import AICreatorViewModel
import Swinject
import SwinjectAutoregistration

final class GeneratorAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IGeneratorViewModel.self, initializer: GeneratorViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IGeneratorService.self, initializer: GeneratorService.init)
    }
}
