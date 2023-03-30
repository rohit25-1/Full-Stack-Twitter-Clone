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
