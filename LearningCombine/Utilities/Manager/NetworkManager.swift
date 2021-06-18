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
    
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completed: @escaping (Result<T, UrlResponseErrors>) -> Void){
        let decoder = JSONDecoder()
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw UrlResponseErrors.unkown
                }
                if (400...499).contains(httpResponse.statusCode){
                    throw UrlResponseErrors.clientError
                }
                if (500...599).contains(httpResponse.statusCode){
                    throw UrlResponseErrors.serverError
                }
                return data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError{ error -> UrlResponseErrors in
                if let responseError = error as? UrlResponseErrors {
                    return responseError
                } else {
                    return UrlResponseErrors.decodeError
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
    
}
