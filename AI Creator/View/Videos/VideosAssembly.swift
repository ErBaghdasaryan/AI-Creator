//
//  VideosAssembly.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import Foundation
import AICreatorViewModel
import Swinject
import SwinjectAutoregistration

final class VideosAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IVideosViewModel.self, initializer: VideosViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IVideosService.self, initializer: VideosService.init)
    }
}
