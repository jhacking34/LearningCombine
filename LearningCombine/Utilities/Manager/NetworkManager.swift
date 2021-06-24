//
//  NetworkManager.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/18/21.
//

import Foundation
import Combine

final class NetworkManager {
    
    static let shared = NetworkManager()
    var cancellables: Set<AnyCancellable> = []
    
    private init () {}
    
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completed: @escaping (Result<T, NetError>) -> Void){
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetError.unkown
                }
                if (400...499).contains(httpResponse.statusCode){
                    throw NetError.clientError
                }
                if (500...599).contains(httpResponse.statusCode){
                    throw NetError.serverError
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError{ error -> NetError in
                if let responseError = error as? NetError {
                    return responseError
                } else {
                    return NetError.decodeError
                }
            }
            .sink(receiveCompletion: { IssueCompletion in
                if case .failure(let error) = IssueCompletion {
                    completed(.failure(error))
                }
            }, receiveValue: { succesfulCompletion in
                completed(.success(succesfulCompletion))
            })
            .store(in: &cancellables)
    }
    
    func upload<Input: Encodable, Output: Decodable>(_ data: Input, to url: URL, httpMethod: String = "POST", contentType: String = "application/json", completion: @escaping (Result<Output, UploadError>) -> Void){
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(data)

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Output.self, decoder: JSONDecoder())
            .map(Result.success)
            .catch{error -> Just<Result<Output,UploadError>> in
                error is DecodingError // This says error == decoding Error
                ? Just(.failure(.decodedFailed)) // ? means if its true
                : Just(.failure(.uploadFailed)) // : means if its false
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
        
    }
    
}
