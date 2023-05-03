//
//  LoginParameters.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 27/04/23.
//

import Foundation

struct LoginParameters : Codable{
    var _id : String
    var email : String
    var name : String
    var password : String
    var username : String?
    var tweets : [String]?
}
