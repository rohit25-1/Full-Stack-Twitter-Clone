//
//  LandingView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 20/04/23.
//

import SwiftUI

struct LandingView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack{
            VStack{
                TwitterTopBarWithoutImage()
                Spacer()
                Text("See what's happening in the world right now.")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .frame(width: 290)
                Spacer()
                Button(action: {
                    
                }, label: {
                    CustomJoiningButtons(image: "google-logo", description: "Continue with Google")
                    
                })
                Button(action: {
                    
                }, label: {
                    CustomJoiningButtons(image: colorScheme == .dark ? "apple-logo-dark" : "apple-logo", description: "Continue with Apple")
                    
                })
                
                Text("Or")
                    .foregroundColor(.gray)
                
                NavigationLink(destination: SignupView()) {
                    Text("Create account")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .frame(width: 330)
                        .padding(.vertical)
                        .background(Color(.systemBlue))
                        .cornerRadius(50)
                }
        
   
                HStack{
                    Text("Have an account already?")
                    NavigationLink("Log in", destination: {
                        LoginView()
                    }).navigationTitle("")
                }.padding()
                    Spacer()
 
            }
        }
        
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

struct CustomJoiningButtons: View {
    let image: String
    let description: String
    var body: some View {
        HStack(spacing: 15){
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 25, height: 25)
                
            Text(description)
                .foregroundColor(.primary)
                .font(.title2)
                .fontWeight(.heavy)
            
        }.frame(width: 330)
            .padding(.vertical)
            .overlay{
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color(.lightGray), lineWidth: 1)
            }
            
            
    }
}
