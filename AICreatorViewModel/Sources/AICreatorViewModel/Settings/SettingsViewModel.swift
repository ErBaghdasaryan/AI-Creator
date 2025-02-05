//
//  SettingsViewModel.swift
//  AICreatorViewModel
//
//  Created by Er Baghdasaryan on 28.01.25.
//

import Foundation
import AICreatorModel

public protocol ISettingsViewModel {
    var settingsItems: [SettingsItem] { get set }
    func loadData()
}

public class SettingsViewModel: ISettingsViewModel {

    private let settingsService: ISettingsService
    public var settingsItems: [SettingsItem] = []

    public init(settingsService: ISettingsService) {
        self.settingsService = settingsService
    }

    public func loadData() {
        self.settingsItems = settingsService.getSettingsItems()
    }
}
