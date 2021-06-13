//
//  ReadWrite.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/12/21.
//

import SwiftUI

struct ReadWrite: View {
    @StateObject private var vm = IntroViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            HeaderView(title: "@Published", subTitle: "Read and Write", desc: "Using a dollar sign ($) we can create a two-way binding.")
            TextField("State", text: $vm.state)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Text(vm.state)
                .padding()
                .frame(width: 215, height: 100, alignment: .center)
                .background(.ultraThinMaterial)
                .cornerRadius(8.0)
            DescView(descripton: "You can now send this value back to the view model acutomatically.")
            
            Spacer()
        }
        .font(.title2)
        .background(
            Image("Caineville")
                .clipped())
    }
}

struct ReadWrite_Previews: PreviewProvider {
    static var previews: some View {
        ReadWrite()
    }
}
