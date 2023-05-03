//
//  TwitterDataModel.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 01/05/23.
//

import Foundation


struct TwitterDataModel : Decodable, Hashable{
    let profilepicture: String
    let name: String
    let username : String
}
 
