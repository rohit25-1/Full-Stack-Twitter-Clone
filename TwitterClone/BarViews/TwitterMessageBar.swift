//
//  TwotterMessageBar.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 03/04/23.
//

import SwiftUI

struct TwitterMessageBar: View {
    @Binding var isClicked : Bool
    @EnvironmentObject var tweets : TweetData
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
                    AsyncImage(url: URL(string: tweets.userData.profilepicture)) { Image in
                        Image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    } placeholder: {
                        Image("default-image")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
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
