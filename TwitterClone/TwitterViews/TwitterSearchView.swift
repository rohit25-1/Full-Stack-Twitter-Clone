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
    let hashtags : HashtagModel
    var body: some View {
        ZStack(alignment: .top){
            TwitterSearchBar(searchField: $searchField, isEditing: $isEditing, isClicked: $isProfilePictureClicked)
                .autocorrectionDisabled()
                .zIndex(2)
            if(!isEditing)
            {
                ScrollView{
                    Spacer(minLength: 90)
                    ForEach(1..<20, content: {_ in
                        VStack(alignment:.leading){
                            Text("#"+hashtags.hashtag)
                                .font(.body)
                                .bold()
                            Text(hashtags.count+" Tweets")
                                .foregroundColor(.gray)
                            Divider()
                        }.frame(width: UIScreen.main.bounds.width-30, alignment: .leading)
                            .padding(.vertical,5)
                    })
                }
            }
            else{
                ScrollView{
                    Spacer(minLength: 90)
                    ForEach(1..<5, content: {_ in
                        HStack(spacing:20){
                            Image("profile-picture")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)
                            VStack(alignment: .leading){
                                Text("Rohit Sridharan")
                                    .font(.title3)
                                    .bold()
                                Text("@rohit25-1")
                                    .foregroundColor(.gray)
                            }
                        }.frame(width: UIScreen.main.bounds.width-20, height: 90, alignment:(.leading))
                        
                        
                    })
                }
            }
            
            
            
        }
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
        TwitterSearchView(isProfilePictureClicked: .constant(false), hashtags: dummyHashtag)
    }
}
