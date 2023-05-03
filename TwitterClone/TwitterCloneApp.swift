//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 28/03/23.
//

import SwiftUI

@main
struct TwitterCloneApp: App {
    @StateObject var authStatus = Authenticate()
    @ObservedObject var tweets = TweetData()
    @State var isLoading = true
    var body: some Scene {
        WindowGroup {
            if(authStatus.isAuthenticated)
            {
                TwitterTabView()
                    .environmentObject(authStatus)
                    .onAppear {
                        tweets.refreshTweets()
                    }
                
            }
            else{
                if(isLoading)
                {
                    ProgressView()
                        .onAppear {
                            let network = NetworkCalls()
                            Task{
                                 if(await !network.isLoggedIn())
                                {
                                    isLoading = false
                                }
                                else{
                                    authStatus.isAuthenticated = true
                                    tweets.refreshTweets()
                                }

                            }
                        }
                    
                }
                else{
                    LandingView().environmentObject(authStatus)
                }
                

            }
        }
    }
}
