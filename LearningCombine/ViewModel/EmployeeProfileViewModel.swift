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
    
    func fetch(){
        let url = URL(string: "https://api.bhico.com/api/v2/swift/_table/beta?api_key=185fbe051e8c1f312afa7c80aa0f2b4a9506d7a24dec0b9da5e326e85198e714")!
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
        // map has Data task publisher error handling
            .decode(type: EmployeeResponse.self, decoder: JSONDecoder())
            .mapError{ error -> UrlResponseErrors in
                if let responseError = error as? UrlResponseErrors {
                    return responseError
                } else {
                    return UrlResponseErrors.decodeError
                }
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                // Decode Error Handling
                    self.errorForAlert = ErrorForAlert(message: "Details: \(error.rawValue)")
                }
                
            }, receiveValue: { [unowned self] employee in
                employees = employee.resource
            })
            .store(in: &cancellables)
    }
}

