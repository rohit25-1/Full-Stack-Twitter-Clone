//
//  TwitterHomeView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 29/03/23.
//

import SwiftUI

struct TwitterHomeView: View {
    @State private var isClicked = false
    @Binding var isProfilePictureClicked : Bool
    @State private var isRefreshing = false // Refreshing
    @State private var spacerLength = CGFloat(100)//For Spacer When Refreshing
    let tweetData : TweetModel
    var body: some View {
        ZStack(alignment:.top){
            TwitterTopBar(isClicked: $isProfilePictureClicked)
                .zIndex(2)
            VStack{
                ScrollView{
                    Spacer(minLength: spacerLength)
                    ForEach(1...10, id: \.self){ _ in
                        VStack{
                            SingleTweetView(tweetData: tweetData)
                            Divider()
                        }
                    }
                }
            }.refreshable {
                isRefreshing = true
                spacerLength = CGFloat(150)
                //Replace below code with Refresing Code
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isRefreshing = false
                    withAnimation(.linear(duration: 0.2))
                    {
                        spacerLength = CGFloat(100)
                    }
                    
                }
            }
            .overlay(
                // Show the refresh icon when the scroll view is being refreshed
                VStack {
                    if isRefreshing {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding(.top, 100)
                    }
                    Spacer()
                }
            )
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        //Write Action for Button Here
                        isClicked.toggle()
                    }, label: {
                        ZStack{
                            Color(.systemBlue)
                                .frame(width: 55, height: 55)
                                .cornerRadius(50)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .tint(.white)
                        }.padding()
                        
                    })
                }
            }
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
        
        .sheet(isPresented: $isClicked, content: {
            NewTweetSheet(isClosed: $isClicked)
        })
        
    }
}

struct TwitterHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterHomeView(isProfilePictureClicked: .constant(false), tweetData: dummyTweet)
    }
}

struct SingleTweetView: View {
    @State var heart = false
    @State var retweet = false
    let tweetData : TweetModel
    var body: some View {
        VStack{
            HStack(alignment: .top){
                Image(tweetData.profilepicture)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .cornerRadius(50)
                VStack(alignment:.leading){
                    HStack{
                        Text(tweetData.name)
                            .bold()
                            .font(.title3)
                        Text(tweetData.twitterId)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text(tweetData.tweet)
                        .font(.body)
                        .frame(maxHeight: 100)
                    
                    
                }
                
            }.padding(.horizontal,5)
            
            
            
            HStack(spacing: 60){
                Button(action: {
                    
                }, label: {
                    Image(systemName: "bubble.left")
                    
                })
                
                Button(action: {
                    retweet.toggle()
                }, label: {
                    Image(systemName: "arrow.2.squarepath")
                        .foregroundColor(retweet ? Color("retweet") : .gray)
                })
                Button(action: {
                    heart.toggle()
                }, label: {
                    Image(systemName: heart ? "heart.fill" : "heart")
                        .foregroundColor(heart ? .red : .gray)
                    
                })
                Button(action: {}, label: {
                    Image(systemName: "bookmark")
                })
            }.padding(.vertical,5)
                .tint(.gray)
            
        }
    }
}
