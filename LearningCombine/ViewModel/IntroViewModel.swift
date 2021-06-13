//
//  IntroViewModel.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/12/21.
//

import Foundation

class IntroViewModel: ObservableObject {
    @Published var state = "1. Begin State"
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.state = "2. Second State!"
        }
    }
}
