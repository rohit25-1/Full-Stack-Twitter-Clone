//
//  TwitterSearchBar.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 01/04/23.
//

import SwiftUI

struct TwitterSearchBar: View {
    @Binding var searchField : String
    @Binding var isEditing : Bool
    @Binding var isClicked : Bool
    @FocusState private var nameIsFocused : Bool
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.regularMaterial)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width , height: 72)
                .zIndex(1)
            
            HStack{
                if(!isEditing)
                {
                    Button(action: {
                        withAnimation(.linear(duration: 0.2))
                        {
                            isClicked = true
                        }
                    }, label: {
                        Image("profile-picture")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(50)
                        
                    }).padding()

                }
                
                HStack{
                    if(isEditing)
                    {
                        Spacer()
                    }
                    
                    TextField("Search Twitter", text: $searchField)
                        .frame(width: isEditing ? UIScreen.main.bounds.width-190 : UIScreen.main.bounds.width-220 , height: 30)
                        .padding(7)
                        .fontWeight(.medium)
                        .padding(.horizontal, 35)
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                        .focused($nameIsFocused)
                        .overlay(alignment: .leading, content: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 13,height: 13)
                                .padding(.horizontal,20)
                                .foregroundColor(.gray)
                        })
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.2))
                            {
                                nameIsFocused = true
                                isEditing = true
                                
                            }
                        }
                        .overlay(alignment: .trailing, content: {
                            if(isEditing)
                            {
                                Image(systemName: "x.circle.fill")
                                    .padding(.horizontal,10)
                                    .foregroundColor(.gray)
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.2))
                                        {
                                            searchField = ""
                                            
                                        }
                                    }
                            }
                            
                        })
                        if(isEditing)
                    {
                            Button(action: {
                                withAnimation(.linear(duration: 0.2))
                                {
                                    searchField = ""
                                    isEditing = false
                                    nameIsFocused = false
                                    
                                }
                            }, label: {
                                Text("Cancel")
                                    .foregroundColor(.primary)
                            })
                    }
                    
                    Spacer()
                }
            
            }.zIndex(2)
        }
    }
}

struct TwitterSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        TwitterSearchBar(searchField: .constant(""), isEditing: .constant(true), isClicked: .constant(false))
    }
}
