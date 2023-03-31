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
}


struct dummy{
    let dummyData = TweetModel(profilepicture: "nil", name: "demo name", tweet: "demo tweet")
}
