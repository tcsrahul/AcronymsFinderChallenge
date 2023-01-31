//
//  NetworkManager.swift
//  AlbertsonChallenge
//
//  Created by 2325761 on 30/01/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private(set) var session = URLSession(configuration: URLSessionConfiguration.default)

    static func parseResponse<T: Decodable>(model: T.Type, data: Data?) -> T? {
        do {
            let decoder = JSONDecoder()
            guard let data = data else { return nil }
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch (let error) {
            print(error.localizedDescription)
            print(error)
            return nil
        }
    }

    func dictionary(shortForm: String,
              result: @escaping (Result<[AcromineDictionary], RequestError>) -> Void) {
        let endpoint = APIManagement.dictionary(shortForm)
        guard let networkRequest = endpoint.networkRequest else {
            result(.failure(RequestError.networkUnknown))
            return
        }
        let task = session.dataTask(with: networkRequest) { requestResult in
            DispatchQueue.main.async {
                switch requestResult {
                case .success((_, let data)):
                    if let successData = NetworkManager.parseResponse(model: [AcromineDictionary].self, data: data) {
                        result(.success(successData))
                    } else {
                        result(.failure(RequestError.parseError))
                    }
                case .failure(let error):
                    result(.failure(error))
                }
            }
        }
        task.resume()
    }

    
}
