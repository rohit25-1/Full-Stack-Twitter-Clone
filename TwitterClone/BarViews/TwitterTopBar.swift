//
//  TwitterTopBar.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 01/04/23.
//

import SwiftUI

struct TwitterTopBar: View {
    @Binding var isClicked : Bool
    @ObservedObject var userData = Authenticate()
    @EnvironmentObject var tweets : TweetData
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.regularMaterial)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width, height: 72)
                .zIndex(1)
            
            HStack{
                Button(action: {
                    withAnimation(.linear(duration: 0.15))
                    {
                        isClicked = true
                    }
                    
                }, label: {
                    //                    Image("profile-picture")
                    //                        .resizable()
                    //                        .frame(width: 40, height: 40)
                    //                        .cornerRadius(50)
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
        TwitterTopBar(isClicked: .constant(false))
    }
}
