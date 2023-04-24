//
//  LoginView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 21/04/23.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var authStatus: Authenticate
    @State private var errorMessage = ""
    var body: some View {
        
        VStack(spacing: 50){
        TwitterTopBarWithoutImage()

            Spacer()
                Text("Sign in to Twitter")
                    .font(.system(size: 30, weight: .heavy))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,30)
            VStack(spacing:20){
                Text(errorMessage)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color(.systemRed))
                    .padding(.horizontal,35)
                TextField("Enter email", text: $email)
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
            }
            
            Spacer()
            Button {
                let network = NetworkCalls()
                Task{
                    if(await !network.loginRequest(formData: LoginParameters(_id: "01", email: email, password: password)))
                    {
                        errorMessage = "Invalid Crededentials"
                    }
                    else{
                        withAnimation(.easeIn(duration: 0.5))
                        {
                            authStatus.isAuthenticated = true
                        }
                    }
                }
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
