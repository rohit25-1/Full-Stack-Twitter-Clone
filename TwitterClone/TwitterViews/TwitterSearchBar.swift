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
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.regularMaterial)
                .ignoresSafeArea()
                .frame(width: .infinity, height: 72)
                .zIndex(1)
                
            HStack{
                Button(action: {

                }, label: {
                    Image("profile-picture")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .cornerRadius(50)
                    
                }).padding()
                Spacer()
                HStack{
                    TextField("Search Twitter", text: $searchField)
                        .frame(width: 200, height: 30)
                                    .padding(7)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 35)
                                    .background(Color(.systemGray5))
                                    .cornerRadius(20)
                                    .padding(.horizontal, 10)
                                    .offset(x: -20)
                                    .overlay(alignment: .leading, content: {
                                        Image(systemName: "magnifyingglass")
                                    })
                                    .onTapGesture {
                                        withAnimation(.linear(duration: 0.2))
                                        {
                                            
                                            isEditing = true
                                            
                                        }
                                    }
                    if(isEditing)
                    {
                        Button(action: {
                            withAnimation(.linear(duration: 0.2))
                            {
                                searchField = ""
                                isEditing = false
                            }
                            
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.gray)
            
                        })
                    }
                    
                }
                
                
                Spacer()
            }.zIndex(2)
        }
    }
}

struct TwitterSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        TwitterSearchBar(searchField: .constant(""), isEditing: .constant(false))
    }
}
