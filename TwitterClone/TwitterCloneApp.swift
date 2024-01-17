//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 28/03/23.
//

import SwiftUI

@main
struct TwitterCloneApp: App {
    @StateObject var tweets = TweetData()
    @State var isLoading = true
    
    var body: some Scene {
        WindowGroup {
            if(tweets.isAuthenticated)
            {
                TwitterTabView()
                    .environmentObject(tweets)
                    .task {
                        withAnimation(.default)
                        {
                            tweets.refreshTweets()
                        }
                        
                    }
            }
            else{
                if(isLoading)
                {
                    ProgressView()
                        .task {
                            let network = NetworkCalls()
                            Task{
                                if(await !network.isLoggedIn())
                                {
                                    isLoading = false
                                }
                                else{
                                    tweets.isAuthenticated = true
                                    tweets.refreshTweets()
                                }
                                
                            }
                        }
                    
                }
                else{
                    LandingView()
                        .environmentObject(tweets)
                }
                
                
            }
        }
    }
}
