//
//  ViewControllerFactory.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 16.01.25.
//

import Foundation
import Swinject
import AICreatorModel
import AICreatorViewModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]

    //MARK: - UntilOnboarding
    static func makeUntilOnboardingViewController() -> UntilOnboardingViewController {
        let assembler = Assembler(commonAssemblies + [UntilOnboardingAssembly()])
        let viewController = UntilOnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IUntilOnboardingViewModel.self)
        return viewController
    }

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: Payment
    static func makePaymentViewController() -> PaymentViewController {
        let assembler = Assembler(commonAssemblies + [PaymentAssembly()])
        let viewController = PaymentViewController()
        viewController.viewModel = assembler.resolver.resolve(IPaymentViewModel.self)
        return viewController
    }

    //MARK: - TabBar
    static func makeTabBarViewController() -> TabBarViewController {
        let viewController = TabBarViewController()
        return viewController
    }

    //MARK: Generator
    static func makeGeneratorViewController() -> GeneratorViewController {
        let assembler = Assembler(commonAssemblies + [GeneratorAssembly()])
        let viewController = GeneratorViewController()
        viewController.viewModel = assembler.resolver.resolve(IGeneratorViewModel.self)
        return viewController
    }

    //MARK: Effects
    static func makeEffectsViewController() -> EffectsViewController {
        let assembler = Assembler(commonAssemblies + [EffectsAssembly()])
        let viewController = EffectsViewController()
        viewController.viewModel = assembler.resolver.resolve(IEffectsViewModel.self)
        return viewController
    }

    //MARK: Videos
    static func makeVideosViewController() -> VideosViewController {
        let assembler = Assembler(commonAssemblies + [VideosAssembly()])
        let viewController = VideosViewController()
        viewController.viewModel = assembler.resolver.resolve(IVideosViewModel.self)
        return viewController
    }

    //MARK: Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    //MARK: Usage
    static func makeUsageViewController() -> UsageViewController {
        let viewController = UsageViewController()
        return viewController
    }
}
