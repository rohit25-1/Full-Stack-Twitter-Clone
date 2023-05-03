//
//  Authenticate.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 24/04/23.
//

import Foundation


struct TweetRequest : Codable{
    var tweet : String
}


class Authenticate : ObservableObject{
    @Published var isAuthenticated = false
    @Published var profilepicture = ""
    @Published var username = ""
    @Published var name = ""
}







