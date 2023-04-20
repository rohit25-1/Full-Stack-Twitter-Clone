//
//  LoginView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 21/04/23.
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        
        VStack(spacing: 50){
        TwitterTopBarWithoutImage()

            Spacer()
                Text("Sign in to Twitter")
                    .font(.system(size: 30, weight: .heavy))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,30)

            TextField("Enter email", text: $username)
                .font(.headline)
                .bold()
                .foregroundColor(Color.primary)
                .frame(width: UIScreen.main.bounds.width-90, height: 70)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.5)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $password)
                .font(.headline)
                .bold()
                .frame(width: UIScreen.main.bounds.width-90, height: 70)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 0.5)
                }
            Spacer()
            Button {
                
            } label: {
                Text("Log in")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-90, height: 60)
                    .background(Color(.systemBlue))
                    .cornerRadius(50)
            }
            Spacer()
     
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
