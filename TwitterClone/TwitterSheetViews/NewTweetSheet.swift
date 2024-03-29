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
    @EnvironmentObject var tweets : TweetData
    
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
                    let network = NetworkCalls()
                    Task{
                        
                        let status = await network.tweetRequest(tweetdata: TweetRequest(tweet: tweetContent))
                        
                        switch status{
                        case .fail:
//                            message = "Error Tweeting"
                            print(" ")
                        case .success:
                            tweets.refreshTweets()
                            isClosed = false
                            
                        case .networkError:
//                            message = "Network Error"
                            print(" ")
                        }
                        
                        
                    }
                }, label: {
                    Text("Tweet")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 80, height: 35)
                        .background(Color(.systemBlue))
                        .cornerRadius(20)
                })
            }.padding()
            HStack(alignment:.top){
                
                AsyncImage(url: URL(string: tweets.userData.profilepicture)) { Image in
                    Image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    Image("profile-picture")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }
                ZStack(alignment:.topLeading){
                    TextEditor(text: $tweetContent)
                        .autocorrectionDisabled()
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
                            {
                                showKeyboard = true
                                
                            }
                        }
                    if(tweetContent.isEmpty)
                    {
                        Text("Whats Happening?")
                            .foregroundColor(.gray)
                            .font(.body)
                            .padding(7.2)
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
            .preferredColorScheme(.dark)
    }
}
