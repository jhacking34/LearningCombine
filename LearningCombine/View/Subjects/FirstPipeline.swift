//
//  FirstPipeline.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/12/21.
//

import SwiftUI

struct FirstPipeline: View {
    @StateObject private var vm = FirstPipelineViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            HeaderView(title: "First Pipeline", subTitle: "Introduction", desc: "This is a simple pipeline created in combine to validate a text field")
            
            HStack{
                TextField("name", text: $vm.name)
                    .textFieldStyle(.roundedBorder)
                Text(vm.validation)
            }
            .padding()
            .frame(width: 200, height: 100, alignment: .center)
            .background(.ultraThinMaterial)
            .cornerRadius(8.0)
            
            Spacer()
        }
        .font(.title)
        .background(
            Image("Caineville")
                .clipped())
    }
}

struct FirstPipeline_Previews: PreviewProvider {
    static var previews: some View {
        FirstPipeline()
    }
}
