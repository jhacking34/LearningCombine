//
//  CancellingMultiplePipelines.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/13/21.
//

import SwiftUI

struct CancellingMultiplePipelines: View {
    @StateObject private var vm = CancellingMulitplePipelinesViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            HeaderView(title: "Cancel All Pipelines", subTitle: "Introduction", desc: "You can use the store fucntion at the end of a pipeline to add your pipelines's cancellable to a Set")
            
            Group{
                HStack{
                    TextField("First name", text: $vm.firstName)
                        .textFieldStyle(.roundedBorder)
                    Text(vm.firstNameValidation)
                }
                
                HStack{
                    TextField("Last name", text: $vm.lastName)
                        .textFieldStyle(.roundedBorder)
                    Text(vm.lastNameValidation)
                }
            }
            .padding()
            
            Button("Cancel All Validations"){
                vm.cancelAllValidations()
            }
            
            
            Spacer()
            
        }
        .font(.title)
        .background(
            Image("Caineville")
                .clipped())
    }
}

struct CancellingMultiplePipelines_Previews: PreviewProvider {
    static var previews: some View {
        CancellingMultiplePipelines()
    }
}
