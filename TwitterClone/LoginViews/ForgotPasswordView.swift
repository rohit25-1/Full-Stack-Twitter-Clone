//
//  ForgotPasswordView.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 24/04/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State private var errorMessage = ""
    @State private var isRegistered = false
    var body: some View {
        NavigationStack{
            ZStack(alignment: .top){
                TwitterTopBarWithoutImage()
                VStack(spacing: 50){
                    
                    
                    Spacer()
                    Text("Forgot password")
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
                        SecureField("Confirm password", text: $confirmPassword)
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
                        Task {
                            if(email != "" && password != "" && confirmPassword != "" && confirmPassword == password)
                            {
                                let status = await network.resetRequest(formData: LoginParameters(_id: "01", email: email, name: "", password: password))
                                
                                switch status{
                                case .fail:
                                    errorMessage = "Error Resetting"
                                case .success:
                                    isRegistered = true
                                case .networkError:
                                    errorMessage = "Network Error"
                                }
                            }
                            else{
                                errorMessage = "Enter All Values"
                            }
                        }
                    } label: {
                        Text("Reset password")
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
        }.navigationTitle("")
            .navigationDestination(isPresented: $isRegistered) {
                LoginView()
            }
            .gesture(DragGesture()
                .onChanged { value in
                    if value.translation.height > 0 {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            )
        
        
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
