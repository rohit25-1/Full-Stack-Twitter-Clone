//
//  TwitterMessageView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 29/03/23.
//

import SwiftUI

struct TwitterMessageView: View {
    @Binding var isProfilePictureClicked : Bool
    @EnvironmentObject var tweets : TweetData
    var body: some View {
        ZStack(alignment: .top){
            TwitterMessageBar(isClicked: $isProfilePictureClicked)
                .zIndex(2)
                .environmentObject(tweets)
            ScrollView{
                Spacer(minLength: 100)

                Divider()
                ForEach(1..<10, content: {_ in
                    HStack(alignment: .top){
                        Image("profile-picture")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        VStack(alignment: .leading){
                            HStack{
                                Text("Rohit Sridharan")
                                    .fontWeight(.bold)
                                    .font(.body)
                                Text("@rohit25-1")
                                    .frame(maxWidth: 70, maxHeight: 10)
                                    .foregroundColor(.gray)
                                Text("01/07/21")
                                    .foregroundColor(.gray)
                            }
                            Text("This is a sample message. This is a sample message.")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                    }.frame(width: UIScreen.main.bounds.width-30, alignment: .leading)
                    Divider()
                })
            }.scrollIndicators(.hidden)
        }
        .onTapGesture {
            if(isProfilePictureClicked == true)
            {
                withAnimation(.linear(duration: 0.2))
                {
                    isProfilePictureClicked = false
                }
                
            }
        }
    }
}

struct TwitterMessageView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterMessageView(isProfilePictureClicked: .constant(false))
    }
}
