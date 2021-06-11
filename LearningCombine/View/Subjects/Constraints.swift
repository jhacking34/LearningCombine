//
//  Constraints.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/11/21.
//

import SwiftUI

struct Constraints: View {
    @State private var comparison = ""
    private let weekendGame = WeekendGame()
    
    var body: some View {
        ZStack{
            Image("Caineville")
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20){
                HeaderView(title: "Constraints", subTitle: "On Associated Types", desc: "You can limit the generic type for the associated type the same way you do with generics.")
                VStack{
                    Button("Evalutate Teams"){
                        comparison = weekendGame.comparTeamSizes()
                    }
                    .padding()
                    
                    Text(comparison)
                        .font(.title2)
                        .padding()
                }
                .frame(width: 315, height: 200, alignment: .center)
                .background(.thickMaterial)
                .cornerRadius(8.0)
                
                
                
                Spacer()
                
            }
            .font(.title)
        }
        
    }
}

struct Constraints_Previews: PreviewProvider {
    static var previews: some View {
        Constraints()
    }
}

protocol Teams {
    associatedtype Team: Collection
    
    var team1: Team { get set }
    var team2: Team { get set }
    
    func comparTeamSizes() -> String
}

struct WeekendGame: Teams{
    var team1 = ["Player One", "Player Two"]
    var team2 = ["Player One", "Player Two", "Player Three"]
    
    func comparTeamSizes() -> String {
        if team1.count > team2.count{
            return "Team 1 has more players"
        } else if team1.count == team2.count {
            return "Both teams are the same size"
        } else {
            return "Team 2 has more players"
        }
    }
    
    
}
