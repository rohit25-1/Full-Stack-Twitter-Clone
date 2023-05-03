//
//  TwitterProfileView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 20/04/23.
//

import SwiftUI
import PhotosUI
struct TwitterProfileView: View {
    @State var openSheet = false
    @EnvironmentObject var tweets : TweetData
    var body: some View {
        VStack{
            Button {
                openSheet = true
            } label: {
                AsyncImage(url: URL(string: tweets.userData.profilepicture)) { Image in
                    Image
                        .resizable()
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())
                } placeholder: {
                    Image("default-image")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .clipShape(Circle())
                }
            }

            
        }.sheet(isPresented: $openSheet, onDismiss: {
            tweets.refreshTweets()
        }, content: {
            ProfilePictureChange()
                .environmentObject(tweets)
        })

        
    }
        
}

struct TwitterProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterProfileView()
    }
}
