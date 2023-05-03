//
//  ProfilePictureChange.swift
//  TwitterClone
//
//  Created by Rohit Sridharan on 30/04/23.
//

import SwiftUI
import PhotosUI
struct ProfilePictureChange: View {
    @State var profilePicture : PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var isImageSelected = false
    @EnvironmentObject var tweets : TweetData
    var body: some View {
        VStack{
            Spacer()
            PhotosPicker(selection: $profilePicture) {
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 130,height: 130)
                }
                else{
                    AsyncImage(url: URL(string: tweets.userData.profilepicture)) { Image in
                        Image
                            .resizable()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())
                    } placeholder: {
                        Image("profile-picture")
                            .resizable()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())
                    }
                    
                }
                
            }.onChange(of: profilePicture) { newItem in
                Task {
                    // Retrieve selected asset in the form of Data
                    if let data = try await newItem?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            }
            
            Spacer()
            Button {
                //write button action
                if(profilePicture == nil)
                {
                    isImageSelected = true
                }
                else{
                    let network = NetworkCalls()
                    Task{
                        if let selectedImageData
                        {
                            if let image = UIImage(data: selectedImageData)
                            {
                                await network.uploadImage(image)
                            }
                            
                        }
                        
                    }
                }
            } label: {
                Text("Update Profile Picture")
                    .frame(width: 250, height: 50)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .bold()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }

        }
        .alert(isPresented: $isImageSelected) {
            Alert(title: Text("Error"), message: Text("Select An Image"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ProfilePictureChange_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePictureChange()
    }
}
