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
}

