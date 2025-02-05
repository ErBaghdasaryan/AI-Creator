//
//  SettingsModel.swift
//  AICreatorModel
//
//  Created by Er Baghdasaryan on 28.01.25.
//
import UIKit

public struct SettingsItem {
    public let title: String
    public let icon: UIImage?
    public let accessoryType: UITableViewCell.AccessoryType

    public init(title: String, icon: UIImage?, accessoryType: UITableViewCell.AccessoryType) {
        self.title = title
        self.icon = icon
        self.accessoryType = accessoryType
    }
}
