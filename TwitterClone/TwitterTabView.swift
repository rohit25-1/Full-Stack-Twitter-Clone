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
    @EnvironmentObject var tweets : TweetData
    
    var body: some View {
        NavigationStack{
            TabView(selection: $selectedTab, content: {
                TwitterHomeView(isProfilePictureClicked: $isOpen)
                    .tabItem({
                        Image(systemName: "house")
                    })
                    .tag(0)
                
                TwitterSearchView(isProfilePictureClicked: $isOpen)
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
            .slideInView(isActive: $isOpen,edge: .leading) {
                TwitterSideView()
                    .environmentObject(tweets)
            }
            
        }.environmentObject(tweets)
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterTabView()
            .preferredColorScheme(.dark)
    }
}
