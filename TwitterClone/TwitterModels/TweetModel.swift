//
//  TweetModel.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 01/04/23.
//

import SwiftUI

struct TweetModel : Decodable, Hashable{
    let profilepicture: String
    let name: String
    let tweet: String
    let username : String
}
 

let dummyTweet = TweetModel(profilepicture: "profile-picture", name: "Rohit Sridharan", tweet: "This Is A Generated Text.", username: "@rohit25-1")

