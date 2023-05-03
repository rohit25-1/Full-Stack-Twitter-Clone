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
    @EnvironmentObject var tweets : TweetData
//    @ObservedObject var tweets = TweetData()
    var body: some View {
        ZStack(alignment:.top){
            TwitterTopBar(isClicked: $isProfilePictureClicked)
                .zIndex(2)
                .environmentObject(tweets)
            VStack{
                if(tweets.tweets.isEmpty)
                {
                    Text("No Tweets")
                }
                else{
                    ScrollView{
                        Spacer(minLength: spacerLength)
                        ForEach(tweets.tweets, id: \.self){ singleTweet in
                            VStack{
                                SingleTweetView(tweetData: singleTweet)
                                Divider()
                            }
                        }
                    }
                    .refreshable {
                        isRefreshing = true
                        spacerLength = CGFloat(150)
                        //Replace below code with Refresing Code
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            Task{
                                tweets.refreshTweets()
                            }
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
                    
                }
            }
            
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
                                .clipShape(Circle())
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
        
        .sheet(isPresented: $isClicked,onDismiss: {
            Task{
                tweets.refreshTweets()
            }
        },  content: {
            NewTweetSheet(isClosed: $isClicked)
        })
        .onAppear {
            tweets.refreshTweets()
        }
        
    }
}

struct TwitterHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterHomeView(isProfilePictureClicked: .constant(false))
    }
}

struct SingleTweetView: View {
    @State var heart = false
    @State var retweet = false
    let tweetData : TweetModel
    var body: some View {
        VStack{
            HStack(alignment: .top){
                AsyncImage(url: URL(string: tweetData.profilepicture)) { Image in
                    Image
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                } placeholder: {
                    Image("profile-picture")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }

//                Image(tweetData.profilepicture)
//                    .resizable()
//                    .frame(width: 45, height: 45)
//                    .cornerRadius(50)
                    
                VStack(alignment:.leading){
                    HStack{
                        Text(tweetData.name)
                            .bold()
                            .font(.title3)
                        Text("@"+tweetData.username)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text(tweetData.tweet)
                        .font(.body)
                        .frame(maxHeight: 100)
                    
                    
                }.padding(.horizontal,10)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,15)
            
            
            
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
            }.padding(.vertical,10)
                .tint(.gray)
            
        }
    }
}
