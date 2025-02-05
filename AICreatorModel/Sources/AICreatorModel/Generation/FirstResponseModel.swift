//
//  FirstResponseModel.swift
//  AICreatorModel
//
//  Created by Er Baghdasaryan on 28.01.25.
//

public struct FirstResponseModel: Codable {
    public let id: String
    public let userID: String
    public let isInvalid: Bool
    public let isFinished: Bool 

    public enum CodingKeys: String, CodingKey {
        case id = "id"
        case userID = "user_id"
        case isFinished = "is_finished"
        case isInvalid = "is_invalid"
    }
}
