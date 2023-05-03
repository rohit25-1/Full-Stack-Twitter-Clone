//
//  TwitterNotificationView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 29/03/23.
//

import SwiftUI

struct TwitterNotificationView: View {
    @Binding var isProfilePictureClicked : Bool
    @EnvironmentObject var tweets : TweetData
    var body: some View {
        ZStack(alignment: .top){
            TwitterNotificationBar(isClicked: $isProfilePictureClicked)
                .zIndex(2)
                .environmentObject(tweets)
            ScrollView{
                Spacer(minLength: 100)
                ForEach(1..<5, content: {_ in
                    VStack(alignment: .leading, spacing: 20){
                        Image("default-image")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                        Text("Rohit Sridharan")
                            .font(.title3)
                            .bold()
                        Text("rohit25-1 has started following you")
                            .foregroundColor(.gray)
                        Divider()
                    }.frame(width: UIScreen.main.bounds.width-50, alignment: .leading)
                })
            }
            .scrollIndicators(.hidden)
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

struct TwitterNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterNotificationView(isProfilePictureClicked: .constant(false))
            .preferredColorScheme(.dark)
    }
}
