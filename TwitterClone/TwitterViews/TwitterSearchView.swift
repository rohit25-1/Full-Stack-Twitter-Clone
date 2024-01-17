//
//  TwitterSearchVieew.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 29/03/23.
//

import SwiftUI

struct TwitterSearchView: View {
    @State var isEditing = false
    @State var searchField = ""
    @FocusState private var isFocused : Bool
    @Binding var isProfilePictureClicked : Bool
    @EnvironmentObject var tweets : TweetData
    let network = NetworkCalls()
    @State var userList : [TwitterDataModel] = [TwitterDataModel(profilepicture: "", name: "", username: "")]
    
    var body: some View {
        ZStack(alignment: .top){
            TwitterSearchBar(searchField: $searchField, isEditing: $isEditing, isClicked: $isProfilePictureClicked)
                .autocorrectionDisabled()
                .zIndex(2)
                .environmentObject(tweets)
            if(!isEditing)
            {
                ScrollView{
                    
                    Spacer(minLength: 90)
                    HStack{
                        Text("Suggested Accounts")
                            .font(.title3)
                            .bold()
                            .padding()
                        Spacer()
                    }
                    
                    ForEach(userList, id: \.self) {userList in
                        HStack(spacing:20){
                            AsyncImage(url: URL(string: userList.profilepicture)) { Image in
                                Image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                Image("profile-picture")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                            VStack(alignment: .leading){
                                Text(userList.name)
                                    .font(.title3)
                                    .bold()
                                Text("@\(userList.username)")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("Follow")
                                    .frame(width: 100, height: 30, alignment: .center)
                                    .background(.blue)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding()
                            })
                        }.frame(width: UIScreen.main.bounds.width-20, height: 90, alignment:(.leading))
                    }
                }
            }
            else{
                
                ScrollView{
                    Spacer(minLength: 90)
                    
                    ForEach(userList, id: \.self) {userList in
                        HStack(spacing:20){
                            AsyncImage(url: URL(string: userList.profilepicture)) { Image in
                                Image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                Image("profile-picture")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                            VStack(alignment: .leading){
                                Text(userList.name)
                                    .font(.title3)
                                    .bold()
                                Text("@\(userList.username)")
                                    .foregroundColor(.gray)
                            }
                        }.frame(width: UIScreen.main.bounds.width-20, height: 90, alignment:(.leading))
                        
                        
                    }
                }
            }
            
            
            
        }.onAppear(perform: {
            Task{
                userList =  await network.userList();
            }
        })
        .onTapGesture {
            if(isProfilePictureClicked == true)
            {
                withAnimation(.linear(duration: 0.2))
                {
                    isProfilePictureClicked = false
                }
                
            }
        }
    }
}

struct TwitterSearchVieew_Previews: PreviewProvider {
    static var previews: some View {
        TwitterSearchView(isProfilePictureClicked: .constant(false))
            .environmentObject(TweetData())
    }
}
