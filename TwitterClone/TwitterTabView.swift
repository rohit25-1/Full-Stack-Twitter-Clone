//
//  ContentView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 28/03/23.
//

import SwiftUI

struct TwitterTabView: View {
    @State private var selectedTab = 0
    @State var isOpen = false
    var body: some View {
        NavigationStack{
            TabView(selection: $selectedTab, content: {
                TwitterHomeView(isProfilePictureClicked: $isOpen, tweetData: dummyTweet)
                    .tabItem({
                        Image(systemName: "house")
                    })
                    .tag(0)
                
                TwitterSearchView(isProfilePictureClicked: $isOpen, hashtags: dummyHashtag)
                    .tabItem({
                        Image(systemName: "magnifyingglass")
                    })
                    .tag(1)
                TwitterNotificationView(isProfilePictureClicked: $isOpen)
                    .tabItem({
                        Image(systemName: "bell")
                    })
                    .tag(2)
                TwitterMessageView(isProfilePictureClicked: $isOpen)
                    .tabItem({
                        Image(systemName: "envelope")
                    })
                    .tag(3)
            })
            .overlay(content: {
                TwitterSideView(isOpen: $isOpen)
                
                
            })
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterTabView()
            .preferredColorScheme(.dark)
    }
}
