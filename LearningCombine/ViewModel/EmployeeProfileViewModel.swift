//
//  EmployeeProfileViewModel.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/14/21.
//

import Foundation
import Combine

class EmployeeProfileViewModel : ObservableObject{
    @Published var employees: [Employee] = []
    @Published var errorForAlert: ErrorForAlert?
    @Published private var requests = Set<AnyCancellable>()
    
    func loadData(){
        let url = URL(string: "https://api.bhico.com/api/v2/swift/_table/beta?api_key=185fbe051e8c1f312afa7c80aa0f2b4a9506d7a24dec0b9da5e326e85198e714")!
        
        NetworkManager.shared.fetch(url, defaultValue: EmployeeResponse.default, completed: { [self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let decodedResult):
                    self.employees = decodedResult.resource
                case .failure(let error):
                    switch error{
                    case .unkown:
                        self.errorForAlert = AlertContext.unkown
                    case .clientError:
                        self.errorForAlert = AlertContext.clientError
                    case .serverError:
                        self.errorForAlert = AlertContext.serverError
                    case .decodeError:
                        self.errorForAlert = AlertContext.decodeError
                    }
                }
            }
            
        })
    }
    
    func upload<Input: Encodable, Output: Decodable>(_ data: Input, to url: URL, httpMethod: String = "POST", contentType: String = "application/json", completion: @escaping (Result<Output, UploadError>) -> Void){
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(data)
        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            DispatchQueue.main.async {
//                if let data = data {
//                    do {
//                        let decoded = try JSONDecoder().decode(Output.self, from: data)
//                        completion(.success(decoded))
//                    } catch {
//                        print(error)
//                        completion(.failure(.decodedFailed))
//                    }
//                } else if error != nil {
//                    completion(.failure(.uploadFailed))
//                } else {
//                    print("Unknown result: no data and no error!")
//                }
//            }
//        }.resume()

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Output.self, decoder: JSONDecoder())
            .map(Result.success)
            .catch{error -> Just<Result<Output,UploadError>> in
                if error is DecodingError{
                    print(error)
                }else{
                    print(error)
                }
                return Just(.failure(.decodedFailed))
                
//                ? Just(.failure(.decodedFailed)) // ? means if its true
//                : Just(.failure(.uploadFailed)) // : means if its false
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
        
    }
}

