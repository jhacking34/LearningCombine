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
    var cancellables: Set<AnyCancellable> = []
    
    func fetch(){
        let url = URL(string: "https://api.bhico.com/api/v2/swifti/_table/beta?api_key=185fbe051e8c1f312afa7c80aa0f2b4a9506d7a24dec0b9da5e326e85198e714")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data}
        // map has Data task publisher error handling
            .decode(type: EmployeeResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    
                    //Decode Error
//                    switch error {
//                    case .invalidResponse:
//                        print("bad")
//
//                    case .invalidURL:
//                        print("bad")
//
//                    case .invalidData:
//                        print("bad")
//
//                    case .unableToComplete:
//                        print("bad")
//                    }
                    print(error)
                }
                
            }, receiveValue: { [unowned self] employee in
                employees = employee.resource
            })
            .store(in: &cancellables)
    }
}

