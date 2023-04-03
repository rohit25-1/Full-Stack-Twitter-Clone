//
//  TwotterMessageBar.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 03/04/23.
//

import SwiftUI

struct TwitterMessageBar: View {
    @Binding var isClicked : Bool
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.regularMaterial)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width , height: 72)
                .zIndex(1)
            
            HStack{
                Button(action: {
                    withAnimation(.linear(duration: 0.2))
                    {
                        isClicked = true
                    }
                }, label: {
                    Image("profile-picture")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .cornerRadius(50)
                    
                }).padding()
                Spacer()
                HStack{
                    Text("Messages")
                        .font(.title3)
                        .bold()
                        .offset(x: -40)
                    
                }
                
                
                Spacer()
            }.zIndex(2)
        }
    }
}

struct TwotterMessageBar_Previews: PreviewProvider {
    static var previews: some View {
        TwitterMessageBar(isClicked: .constant(false))
    }
}
