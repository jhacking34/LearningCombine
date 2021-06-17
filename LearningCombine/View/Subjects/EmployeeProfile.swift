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
                Text("Employee name: \(employee.fname) \(employee.lname) and email addy is: \(employee.email) ")
            }
            .font(.body)
            Spacer()
            
        }
        .font(.title)
        .background(
            Image("Caineville")
                .clipped())
        .onAppear {
            vm.loadData()
        }
        .alert(item: $vm.errorForAlert) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message))
        }
    }
}

struct EmployeeProfile_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeProfile()
    }
}
