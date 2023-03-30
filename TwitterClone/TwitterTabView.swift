//
//  ContentView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 28/03/23.
//

import SwiftUI

struct TwitterTabView: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab, content: {
            TwitterHomeView()
                .tabItem({
                    Image(systemName: "house")
                })
                .tag(0)
            TwitterSearchView()
                .tabItem({
                    Image(systemName: "magnifyingglass")
                })
                .tag(1)
            TwitterNotificationView()
                .tabItem({
                    Image(systemName: "bell")
                })
                .tag(2)
            TwitterMessageView()
                .tabItem({
                    Image(systemName: "envelope")
                })
                .tag(3)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterTabView()
            .preferredColorScheme(.dark)
    }
}
