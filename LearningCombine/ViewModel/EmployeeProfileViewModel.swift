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
    @Published var empFirstName = ""
    @Published var empLastName = ""
    @Published var empEmail = ""
    @Published var empID = 0.0
    @Published var empImage = ""
    
    let url = URL(string: "https://api.bhico.com/api/v2/swift/_table/beta?api_key=185fbe051e8c1f312afa7c80aa0f2b4a9506d7a24dec0b9da5e326e85198e714")!
    
    func loadData(){
        
        
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
    
    func uploadData(){
        let newEmployee = Employee(id: UUID().uuidString, empID: Int(empID), fname: empFirstName, lname: empLastName, email: empEmail, imageURL: empImage)
        let newEmployees = EmployeeResponse(resource: [newEmployee])
        
        NetworkManager.shared.upload(newEmployees, to: url) { (result: Result<ResponseDecode,UploadError>) in
            switch result {
            case .success(_):
                self.errorForAlert = AlertContext.sucessful
            case .failure(let failure):
                switch failure{
                case .decodedFailed:
                    self.errorForAlert = AlertContext.decodeError
                case .uploadFailed:
                    self.errorForAlert = AlertContext.serverError
                }
            }
        }
    }
    
    
}

