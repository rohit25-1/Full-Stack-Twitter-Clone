//
//  TweetData.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 27/04/23.
//

import Foundation

class TweetData: ObservableObject {
    @Published var isAuthenticated = false
    @Published var tweets: [TweetModel] = []
    @Published var userData : TwitterDataModel = TwitterDataModel(profilepicture: "", name: "", username: "")
    func refreshTweets(){
        let network = NetworkCalls()
        Task {
            let newTweets = await network.allTweetData()
            let fetchedData = await network.userDetails()
            DispatchQueue.main.async {
                self.tweets = newTweets
                self.userData = fetchedData
                print(self.userData)
            }
        }
    }
    

}
