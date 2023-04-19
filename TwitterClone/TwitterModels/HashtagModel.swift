//
//  HashtagModel.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 20/04/23.
//
import SwiftUI

struct HashtagModel : Identifiable, Decodable{
    var id = UUID()
    let hashtag : String
    let count : String
}



    let dummyHashtag = HashtagModel(hashtag: "Dhoni", count: "18k")

