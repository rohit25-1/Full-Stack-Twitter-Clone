//
//  TweetModel.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 01/04/23.
//

import SwiftUI

struct TweetModel : Identifiable, Decodable{
    var id = UUID()
    let profilepicture: String
    let name: String
    let tweet: String
    let twitterId : String
}



    let dummyData = TweetModel(profilepicture: "profile-picture", name: "Rohit Sridharan", tweet: "This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.", twitterId: "@rohit25-1")

