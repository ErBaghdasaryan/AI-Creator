//
//  GeneratorViewModel.swift
//  AICreatorViewModel
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import Foundation
import AICreatorModel

public protocol IGeneratorViewModel {
    var userID: String { get }
    var appStorageService: IAppStorageService { get set }
    func doFirstCall<T: Decodable, U: Encodable>(
        from urlString: String,
        httpMethod: String,
        body: U?,
        accessToken: String?,
        responseModel: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

public class GeneratorViewModel: IGeneratorViewModel {

    private let generatorService: IGeneratorService
    public var appStorageService: IAppStorageService

    public var userID: String {
        get {
            return String(appStorageService.getData(key: .apphudUserID) ?? "")
        }
    }

    public init(generatorService: IGeneratorService, appStorageService: IAppStorageService) {
        self.generatorService = generatorService
        self.appStorageService = appStorageService
    }

    public func doFirstCall<T: Decodable, U: Encodable>(
        from urlString: String,
        httpMethod: String = "POST",
        body: U? = nil,
        accessToken: String? = nil,
        responseModel: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {

        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = httpMethod

        if let body = body {
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(NetworkError.invalidURL))
                return
            }
        }

        if let accessToken = accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 1
        config.timeoutIntervalForRequest = 60
        config.timeoutIntervalForResource = 120

        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.noData))
                }
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(responseModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
