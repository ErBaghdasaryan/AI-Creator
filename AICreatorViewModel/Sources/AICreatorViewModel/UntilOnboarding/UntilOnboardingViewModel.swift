//
//  UntilOnboardingViewModel.swift
//  AICreatorViewModel
//
//  Created by Er Baghdasaryan on 21.01.25.
//

import Foundation
import AICreatorModel

public protocol IUntilOnboardingViewModel {
    var skipOnboarding: Bool { get set }
    var appStorageService: IAppStorageService { get set }
}

public class UntilOnboardingViewModel: IUntilOnboardingViewModel {

    public var skipOnboarding: Bool {
        get {
            return appStorageService.hasData(for: .skipOnboarding)
        }
        set {
            appStorageService.saveData(key: .skipOnboarding, value: newValue)
        }
    }

    private let untilOnboardingService: IUntilOnboardingService
    public var appStorageService: IAppStorageService

    public init(untilOnboardingService: IUntilOnboardingService, appStorageService: IAppStorageService) {
        self.untilOnboardingService = untilOnboardingService
        self.appStorageService = appStorageService
    }
}
