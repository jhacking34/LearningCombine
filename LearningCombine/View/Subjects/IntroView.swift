//
//  IntroView.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/12/21.
//

import SwiftUI

struct IntroView: View {
    @StateObject private var vm = IntroViewModel()
    
    var body: some View {
        VStack{
            HeaderView(title: "@Published", subTitle: "Introduction", desc: "@Published property wrapper with the ObersvableObject is the publisher. It send outs a message to the view whenver its value has changed. The stateobject property wrapper helps to make the view the subscriber.")
                .padding(.bottom, 35)
            
            Text(vm.state)
                .frame(width: 220, height: 100, alignment: .center)
                .background(.thinMaterial)
                .cornerRadius(8.0)
                .padding()
            
            DescView(descripton: "When the state property changes after 1 second, the UI updates in the response. This is the read-only from your view model.")
            
            Spacer()
        }
        .font(.title)
        .background(
            Image("Caineville")
                .clipped())
        
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
