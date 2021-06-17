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
    
    var cancellables: Set<AnyCancellable> = []
    
    func loadData(){
        let url = URL(string: "https://api.bhico.com/api/v2/1swift/_table/beta?api_key=185fbe051e8c1f312afa7c80aa0f2b4a9506d7a24dec0b9da5e326e85198e714")!
        
        fetch(url, defaultValue: EmployeeResponse.default) {
            self.employees = $0.resource
        }
    }
    
    func fetch<T: Decodable, U: Error>(_ url: URL, defaultValue: T, _ networkUrlError: U, completion: @escaping (T) -> Void){
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
            .mapError{ error -> Never in
                    if let responseError = error as? NetError {
                                return responseError
                            } else {
                                return UrlResponseErrors.decodeError
                            }
                        }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                                if case .failure(let error) = completion {
                                // This inserts the error into the Error alert message and pulls that message from our UrlResponseErrors Model
                                    self.errorForAlert = ErrorForAlert(message: "Details: \(error.rawValue)")
                                }
                
                            },receiveValue: completion)
            .store(in: &cancellables)
    }
    
//    func fetch(){
//        let url = URL(string: "https://api.bhico.com/api/v2/swift/_table/beta?api_key=185fbe051e8c1f312afa7c80aa0f2b4a9506d7a24dec0b9da5e326e85198e714")!
//        URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap { (data: Data, response: URLResponse) -> Data in
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    throw UrlResponseErrors.unkown
//                }
//                if (400...499).contains(httpResponse.statusCode){
//                    throw UrlResponseErrors.clientError
//                }
//                if (500...599).contains(httpResponse.statusCode){
//                    throw UrlResponseErrors.serverError
//                }
//                return data
//            }
//            .decode(type: EmployeeResponse.self, decoder: JSONDecoder()) //look at the Employee Model to get breakdown of type
//            .mapError{ error -> UrlResponseErrors in // This mapError is looking to return a UrlResponseError type.
//                //This right here is check the error and trys to unwrap the optional as a UrlResponseErrors.  If the error is not that type it means its a different and runs the else
//                if let responseError = error as? UrlResponseErrors {
//                    print(error)
//                    return responseError
//                } else {
//                    print(error)
//                    // We return the UrlResponseErrors.decodeError because that is what this closure is looking for and we do that cuz this else statement got ran because it
//                    // was not of type UrlResponseErrors AKA URL Error and so we assume its a different error dealing with the decode. so we return the generic decode error we built in that model.
//                    return UrlResponseErrors.decodeError
//                }
//            }
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { completion in
//                if case .failure(let error) = completion {
//                // This inserts the error into the Error alert message and pulls that message from our UrlResponseErrors Model
//                    self.errorForAlert = ErrorForAlert(message: "Details: \(error.rawValue)")
//                }
//
//            }, receiveValue: { [unowned self] employee in
//                employees = employee.resource //look at the employee model to see why we used employee.resource
//            })
//            .store(in: &cancellables)
//    }
}

