//
//  URLDataTaskPublisher_Intro.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/13/21.
//

import SwiftUI

struct URLDataTaskPublisher_Intro: View {
    @StateObject private var vm = URLDataTaskPublisher_IntroViewModel()
    
    var body: some View {
        VStack(spacing: 20){
            HeaderView(title: "URLSession Data Task Publisher", subTitle: "Introduction", desc: "URLSession has a datataskPublisher you can use to get data from a URL and run it through a pipeling")
            
            List(vm.dataToView, id: \._id) { catFact in
                Text(catFact.text)
            }
            .font(.title3)
            
            Spacer()
        }
        .font(.title)
        .background(
            Image("Caineville")
                .clipped())
        .onAppear {
            vm.fetch()
        }
    }
}

struct URLDataTaskPublisher_Intro_Previews: PreviewProvider {
    static var previews: some View {
        URLDataTaskPublisher_Intro()
    }
}
