//
//  DescView.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/11/21.
//

import SwiftUI

struct DescView: View {
    
    var descripton : String
    
    var body: some View {
        Text(descripton)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .font(.title2)
    }
}

struct DescView_Previews: PreviewProvider {
    static var previews: some View {
        DescView(descripton: "Use this to...")
    }
}
