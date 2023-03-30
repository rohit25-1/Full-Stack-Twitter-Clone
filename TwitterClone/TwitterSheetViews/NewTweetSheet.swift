//
//  NewTweetSheet.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 29/03/23.
//

import SwiftUI

struct NewTweetSheet: View {
    @State private var tweetContent = ""
    @FocusState var showKeyboard : Bool
    @Binding var isClosed : Bool
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    isClosed = false
                }, label: {
                    Text("Cancel")
                })
                Spacer()
                Button(action: {
                    //invoke new tweet action
                    //yet to do
                }, label: {
                    Text("Tweet")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 35)
                        .background(Color(.systemBlue))
                        .cornerRadius(20)
                })
            }.padding()
            HStack{
                Image("profile-picture")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
                TextField("Whats Happening?", text: $tweetContent)
                    .focused($showKeyboard)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
                        {
                            showKeyboard = true
                        }
                    }
            }.padding(.horizontal)
            Spacer()
            
        }
    }
}

struct NewTweetSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetSheet(isClosed: .constant(false))
    }
}
