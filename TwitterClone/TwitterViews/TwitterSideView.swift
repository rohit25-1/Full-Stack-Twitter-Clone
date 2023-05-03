//
//  TwitterSideView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 03/04/23.
//

import SwiftUI

struct TwitterSideView: View {
    @Environment(\.colorScheme) var colorScheme
//    @Binding var isOpen : Bool
    @Binding var authStatus : Bool
    @EnvironmentObject var tweets : TweetData
    //    @ObservedObject var tweets = TweetData()
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                NavigationLink(destination: TwitterProfileView(), label: {
                    AsyncImage(url: URL(string: tweets.userData.profilepicture)) { Image in
                        Image
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    } placeholder: {
                        Image("default-image")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    }
                    
                }).navigationTitle("")
                    .environmentObject(tweets)
                
                
                Text(tweets.userData.name)
                    .bold()
                    .font(.title3)
                Text("@"+tweets.userData.username)
                    .font(.headline)
                    .foregroundColor(.gray)
                HStack{
                    Text("70")
                        .bold()
                    Text("Following")
                        .foregroundColor(.gray)
                    Text("5")
                        .bold()
                    Text("Followers")
                        .foregroundColor(.gray)
                }.padding(.vertical)
                Divider()
                VStack(alignment: .leading){
                    ForEach(menuArray, id: \.self ,  content: {items in
                        HStack(spacing: 30){
                            Image(systemName: items.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            Text(items.name)
                                .font(.title2)
                                .bold()
                        }.frame(height: 80, alignment: .leading)
                    })
                }
                Spacer()
                Button {
                    withAnimation(.linear(duration: 0.5))
                    {
                        let defaults = UserDefaults.standard
                        defaults.removeObject(forKey: "jwt")
                        authStatus = false
                    }
                    let network = NetworkCalls()
                    Task{
                        await network.isLoggedIn()
                    }
                    
                } label: {
                    Text("Logout")
                        .frame(width: 140, height: 40)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                        .bold()
                }
                
                
            }.shadow(radius: 0.2)
                .padding()
                .background(.regularMaterial)
            //                .offset(x: isOpen ? 0 : -UIScreen.main.bounds.width)
            
            //                .frame(width: UIScreen.main.bounds.width-150, alignment: .leading)
            //            Rectangle()
            //                .offset(x: isOpen ? 0 : -UIScreen.main.bounds.width)
            //                .onTapGesture {
            //                    withAnimation(.easeIn(duration: 0.2))
            //                    {
            //                        isOpen = false
            //                    }
            //                    print("Hello")
            //                }
            
            //            Spacer()
            
        }
        
        
        
    }
}

struct TwitterSideView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterSideView(authStatus: .constant(false))
    }
}
