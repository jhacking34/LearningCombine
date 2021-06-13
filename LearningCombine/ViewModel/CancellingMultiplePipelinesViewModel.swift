//
//  CancellingMultiplePipelinesViewModel.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/13/21.
//

import Foundation
import Combine
import UIKit

class CancellingMulitplePipelinesViewModel: ObservableObject{
    @Published var firstName: String = ""
    @Published var firstNameValidation: String = ""
    @Published var lastName: String = ""
    @Published var lastNameValidation: String = ""
    
    // Here is your kitchn sink Subscripber (it can be turned off or on)
    private var validationCancellables: Set<AnyCancellable> = []
    
    init(){
        $firstName // Publisher  -- Water Tower
            .map { $0.isEmpty ? "❌" : "✅"} // Operator Processing data -  In the pipeline
            .sink { [unowned self] value in // Cancellable subscriber to do stuff with data followed up with the store in subscriber  -  House/kitchen getting water
                self.firstNameValidation = value
            }
            .store(in: &validationCancellables) // store in subscriber
        
        $lastName
            .map { $0.isEmpty ? "❌" : "✅"}
            .sink { [unowned self] value in
                self.lastNameValidation = value
            }
            .store(in: &validationCancellables)
    }
    
    // Once this function runs the pipeline is cancelled.
    func cancelAllValidations() {
        validationCancellables.removeAll() // by removing the AnyCancellable reference makes the pipeline no longer work have a place in memory.  this means sink is cancelled and the publisher
        //$ firstName and $lastName will no longer published data.  The sink is drained!!!!
    }
}
