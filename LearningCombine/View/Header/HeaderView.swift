//
//  HeaderView.swift
//  LearningCombine
//
//  Created by Johnny Hacking on 6/11/21.
//

import SwiftUI

struct HeaderView: View {
    var title : String
    var subTitle : String
    var desc : String
    
    var body: some View {
        VStack(spacing: 15){
            if !title.isEmpty{
                Text(title)
                    .font(.largeTitle)
            }
            
            Text(subTitle)
                .foregroundColor(.gray)
            
            DescView(descripton: desc)
        }
        .padding(.top, 50)
        .background(.thinMaterial)
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", subTitle: "SubTitle", desc: "Us this to...")
    }
}
