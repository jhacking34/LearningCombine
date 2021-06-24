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
            
            VStack{
                HStack{
                    TextField("First Name: ", text: $vm.empFirstName)
                    TextField("Last Name: ", text: $vm.empLastName)
                }
                TextField("Email: ", text: $vm.empEmail)
                HStack{
                    Slider(value: $vm.empID, in: 1...100, step: 1)
                    Text("\(Int(vm.empID))")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                }
                
            }
            .padding()
            .background(Color.green)
            .textFieldStyle(.roundedBorder)
        
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
                    
                    vm.uploadData()
                    
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
