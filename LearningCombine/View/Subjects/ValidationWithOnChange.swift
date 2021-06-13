//
//  ValidationWithOnChange.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/12/21.
//

import SwiftUI

struct ValidationWithOnChange: View {
    @StateObject private var vm = OnChangeViewModel()
    @State private var message = ""
    
    var body: some View {
        VStack{
            HeaderView(title: "@Published", subTitle: "onChange", desc: "You could use the onChange to validate data entry. While this works, you may want to move this logic to your view model.")
            
            HStack{
                TextField("name", text: $vm.name)
                    .textFieldStyle(.roundedBorder)
                //Lets move this onto the view model and use combine.....
                    .onChange(of: vm.name) { newValue in
                        message = newValue.isEmpty ? "❌" : "✅"
                    }
                Text(message)
            }
            .padding()
            .frame(width: 275, height: 100, alignment: .center)
            .background(.ultraThinMaterial)
            .cornerRadius(8.0)
            
            Spacer()
        }
        .font(.title2)
        .background(
            Image("Caineville")
                .clipped())
    }
}

struct ValidationWithOnChange_Previews: PreviewProvider {
    static var previews: some View {
        ValidationWithOnChange()
    }
}
