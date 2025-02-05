//
//  GenerationSendModel.swift
//  AICreatorModel
//
//  Created by Er Baghdasaryan on 28.01.25.
//

public struct GenerationSendModel: Codable {
    public let prompt, userID, appBundle: String

    public enum CodingKeys: String, CodingKey {
        case prompt
        case userID = "user_id"
        case appBundle = "app_bundle"
    }

    public init(prompt: String, userID: String, appBundle: String) {
        self.prompt = prompt
        self.userID = userID
        self.appBundle = appBundle
    }
}
