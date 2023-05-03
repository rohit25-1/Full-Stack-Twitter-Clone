//
//  TwitterNotificationBar.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 03/04/23.
//

import SwiftUI

struct TwitterNotificationBar: View {
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
                    Text("Notifications")
                        .font(.title3)
                        .bold()
                        .offset(x: -40)
                    
                }
                
                
                Spacer()
            }.zIndex(2)
        }
    }
}

struct TwitterNotificationBar_Previews: PreviewProvider {
    static var previews: some View {
        TwitterNotificationBar(isClicked: .constant(false))
    }
}
