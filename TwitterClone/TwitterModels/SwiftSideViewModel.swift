//
//  SwiftSideViewModel.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 03/04/23.
//

import Foundation

struct menuitems : Hashable{
    let icon : String
    let name : String
}

let menuArray : [menuitems] = [ menuitems(icon: "person", name: "Profile"),
                                menuitems(icon: "text.bubble", name: "Topics"),
                                menuitems(icon: "bookmark", name: "Bookmarks"),
                                menuitems(icon: "list.bullet.rectangle.portrait", name: "Lists"),
]
