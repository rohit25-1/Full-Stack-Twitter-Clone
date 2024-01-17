//
//  UserData.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 15/01/24.
//

import Foundation
import SwiftData

@Model
class UserData{
    var token : String
    var profilepicture: String
    var username : String
    var name : String
    
    init(token: String, profilepicture: String, username: String, name: String) {
        self.token = token
        self.profilepicture = profilepicture
        self.username = username
        self.name = name
    }
}
