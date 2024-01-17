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
    @EnvironmentObject var authStatus: TweetData
    @State private var errorMessage = ""
    @FocusState private var usernamIsFocused: Bool
    @FocusState private var passwordIsFocused : Bool
    var body: some View {
        ZStack(alignment: .top){
            TwitterTopBarWithoutImage()
            Rectangle()
                .fill(.background)
                .onTapGesture {
                    usernamIsFocused = false
                    passwordIsFocused = false
                }
                .gesture(DragGesture().onChanged{value in
                    if value.translation.height > 0 {
                        usernamIsFocused = false
                        passwordIsFocused = false
                    }})
            
            VStack(spacing: 50){
                
                
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
                        .focused($usernamIsFocused)
                    
                    SecureField("Password", text: $password)
                        .font(.headline)
                        .bold()
                        .frame(width: UIScreen.main.bounds.width-90, height: 70)
                        .padding(.horizontal)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 0.5)
                        }
                        .focused($passwordIsFocused)
                    NavigationLink {
                        ForgotPasswordView()
                    } label: {
                        Text("Forgot password?")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal,37)
                            .foregroundColor(Color(.systemBlue))
                    }
                    
                }
                
                Spacer()
                Button {
                    let network = NetworkCalls()
                    Task{
                        if(email != "" && password != "")
                        {
                            let status = await network.loginRequest(formData: LoginParameters(_id: "01", email: email, name: "", password: password))
                            
                            switch status{
                            case .fail:
                                errorMessage = "Invalid Credentials"
                            case .success:
                                withAnimation(.easeIn(duration: 0.5))
                                {
                                    authStatus.isAuthenticated = true
                                }
                            case .networkError:
                                errorMessage = "Network Error"
                            }
                        }
                        else{
                            errorMessage = "Enter email and password"
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
        }.navigationTitle("")
        
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
