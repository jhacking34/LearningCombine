//
//  URLDataTaskPublisher_IntroViewModel.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/13/21.
//

import Foundation
import Combine

class URLDataTaskPublisher_IntroViewModel: ObservableObject {
    @Published var dataToView: [CatFact] = []
    var cancellables: Set<AnyCancellable> = []
    
    func fetch(){
        let url = URL(string: "https://cat-fact.herokuapp.com/facts")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data}
            .decode(type: [CatFact].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [unowned self] catFact in
                dataToView = catFact
            })
            .store(in: &cancellables)
    }
}
