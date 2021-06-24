//
//  EmployeeProfile.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/14/21.
//

import SwiftUI

struct EmployeeProfile: View {
    @StateObject private var vm = EmployeeProfileViewModel()
    
    var body: some View {
        VStack{
            HeaderView(title: "Employee Profile", subTitle: "First Pull Via API", desc: "I am pulling info from BHI API to see how this will work to prepare for the other apps I am making.")
        
            List(vm.employees, id: \.id) { employee in
                Text("Employee name: \(employee.fname) \(employee.lname) and email addy is: \(employee.email) here is employee number: \(employee.empID)")
            }
            .font(.body)
            Spacer()
            HStack{
                Button(action:{
                    vm.loadData()
                }){
                    Text("Load Data")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
                Button(action:{
                    let uploadURL = URL(string: "https://api.bhico.com/api/v2/swift/_table/beta?api_key=185fbe051e8c1f312afa7c80aa0f2b4a9506d7a24dec0b9da5e326e85198e714")!
                    let newEmployee = Employee(id: "238i9", empID: 10, fname: "Jerzee", lname: "Hacking", email: "Jhacking@bhico.com", imageURL: "nothing")
                    let newEmployees = EmployeeResponse(resource: [newEmployee])
                    
                    vm.upload(newEmployees, to: uploadURL) { (result: Result<SucessDecode, UploadError>) in
//                        switch result {
//                            case .success(let star):
//                            print("Received back \(star)")
//                            case .failure(let error):
//                                print(error)
//                                break
//                            }
                        switch result {
                        case .success(let success):
                            print("Got Back \(success)")
                        case .failure(let failure):
                            print("Here what we got: \(failure)")
                            break
                        }
                    }
                    
                }){
                    Text("Upload Data")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
            
            
        }
        .font(.title)
        .background(
            Image("Caineville")
                .clipped())
        .alert(item: $vm.errorForAlert) { alert in
            Alert(title: alert.title, message: alert.message)
        }
    }
}

struct EmployeeProfile_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeProfile()
    }
}
