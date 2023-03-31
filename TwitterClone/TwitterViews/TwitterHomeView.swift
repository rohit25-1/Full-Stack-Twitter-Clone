//
//  TwitterHomeView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 29/03/23.
//

import SwiftUI

struct TwitterHomeView: View {
    @State private var isClicked = false
    var body: some View {
        ZStack{
            ScrollView{
                Spacer(minLength: 100)
                ForEach(1...10, id: \.self){ _ in
                    VStack{
                        SingleTweetView()
                            Divider()
                        }
                }
            }
            

                
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        //Write Action for Button Here
                        isClicked.toggle()
                    }, label: {
                        ZStack{
                            Color(.systemBlue)
                                .frame(width: 55, height: 55)
                                .cornerRadius(50)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .tint(.white)
                        }.padding()
                        
                    })
                }
            }
        }
        
        .sheet(isPresented: $isClicked, content: {
            NewTweetSheet(isClosed: $isClicked)
        })
        
        
               
    }
}

struct TwitterHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TwitterHomeView()
    }
}

struct SingleTweetView: View {
    var body: some View {
        HStack(alignment: .top){
            Image("profile-picture")
                .resizable()
                .frame(width: 45, height: 45)
                .cornerRadius(50)
            VStack(alignment:.leading){
                HStack{
                    Text("Rohit Sridharan")
                        .bold()
                        .font(.title3)
                    Text("@rohit25-1")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Text("This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.This Is A Generated Text.")
                    .font(.body)
                    .frame(maxHeight: 100)
                HStack(spacing: 70){
                    Button(action: {}, label: {
                        Image(systemName: "bubble.left")
                    })
                    
                    Button(action: {}, label: {
                        Image(systemName: "arrow.2.squarepath")
                    })
                    Button(action: {}, label: {
                        Image(systemName: "heart")
                    })
                    Button(action: {}, label: {
                        Image(systemName: "bookmark")
                    })
                }.padding(.vertical,5)
                    .tint(.gray)

            }
        }.padding(.horizontal,5)
    }
}
