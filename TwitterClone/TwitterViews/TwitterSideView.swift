//
//  TwitterSideView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 03/04/23.
//

import SwiftUI

struct TwitterSideView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isOpen : Bool
    var body: some View {

            HStack{
                VStack(alignment:.leading){
                    NavigationLink(destination: TwitterProfileView(), label: {
                        Image("profile-picture")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(50)
                    
                    }).navigationTitle("")
                    
                    
                    Text("Rohit")
                        .bold()
                        .font(.title3)
                    Text("@rohit25-1")
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
                    Button(action: {
                        
                    }, label: {
                        Text("Logout")
                            .frame(width: 140, height: 40)
                            .background(Color(.systemBlue))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    })
                    
                }.frame(width: UIScreen.main.bounds.width-150, alignment: .leading)
                    .padding()
                    .background(.regularMaterial)
                    .offset(x: isOpen ? 0 : -UIScreen.main.bounds.width)
                    .shadow(radius: 0.2)
                
                Spacer()
            }

        
        
    }
}

struct TwitterSideView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterSideView(isOpen: .constant(true))
    }
}
