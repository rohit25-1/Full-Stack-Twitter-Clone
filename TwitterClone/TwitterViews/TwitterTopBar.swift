//
//  TwitterTopBar.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 01/04/23.
//

import SwiftUI

struct TwitterTopBar: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.regularMaterial)
                .ignoresSafeArea()
                .frame(width: .infinity, height: 72)
                .zIndex(1)
                
            HStack{
                Button(action: {
                    
                }, label: {
                    Image("profile-picture")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .cornerRadius(50)
                }).padding()
                Spacer()
                Image("twitter-logo")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .offset(x: -35)
                Spacer()
            }.zIndex(2)
        }
        
    }
}

struct TwitterTopBar_Previews: PreviewProvider {
    static var previews: some View {
        TwitterTopBar()
    }
}
