//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 28/03/23.
//

import SwiftUI

@main
struct TwitterCloneApp: App {
    @StateObject var authStatus = Authenticate()
    var body: some Scene {
        WindowGroup {
            if(authStatus.isAuthenticated)
            {
                TwitterTabView().environmentObject(authStatus)
            }
            else{
                LandingView().environmentObject(authStatus)
            }
        }
    }
}
