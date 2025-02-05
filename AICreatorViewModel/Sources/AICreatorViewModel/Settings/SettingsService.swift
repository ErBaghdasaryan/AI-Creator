//
//  SettingsService.swift
//  AICreatorViewModel
//
//  Created by Er Baghdasaryan on 28.01.25.
//

import UIKit
import AICreatorModel

public protocol ISettingsService {
    func getSettingsItems() -> [SettingsItem]
}

public class SettingsService: ISettingsService {
    public init() { }

    public func getSettingsItems() -> [SettingsItem] {
        [
            SettingsItem(title: "Rate the app",
                         icon: UIImage(named: "rate"),
                         accessoryType: .disclosureIndicator),
            SettingsItem(title: "Share the app",
                         icon: UIImage(named: "share"),
                         accessoryType: .disclosureIndicator),
            SettingsItem(title: "Usage Policy",
                         icon: UIImage(named: "usage"),
                         accessoryType: .disclosureIndicator),
            SettingsItem(title: "Restore Purchases",
                         icon: UIImage(named: "restore"),
                         accessoryType: .disclosureIndicator),
        ]
    }

}
