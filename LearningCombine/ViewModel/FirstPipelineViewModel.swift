//
//  FirstPipeline.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/12/21.
//

import Foundation
//import Combine

class FirstPipelineViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var validation: String = ""
    
    init(){
        //combine pipeline here
        
        //Publisher (Water Tower
        $name
            .map{ $0.isEmpty ? "❌" : "✅"} // Operator (Value in waterline to adjust water preasure)
            .assign(to: &$validation) // Subscriber (House receiving water or kitchen sink in house)
    }
}
