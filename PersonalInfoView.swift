//
//  PersonalInfoView.swift
//  AlDwaaNewApp
//
//  Created by Eslam ALi on 12/07/2023.
//

import SwiftUI

struct PersonalInfoView: View {
    
    @StateObject  var userProfileVM :UserProfileVM
    @State private var willMoveToChangePassword = false
    @State private var willMoveToUpdate = false
    @State private var isShowingPopup = false
    
    @State private var isShowingEdit = false
    @StateObject var imagePickerManger: ImagePickerManger
    
    init(userProfileVM :UserProfileVM,imagePickerManger :ImagePickerManger ) {
        _userProfileVM = StateObject(wrappedValue: userProfileVM)
        _imagePickerManger = StateObject(wrappedValue: imagePickerManger)
    }
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    top_View
                    Spacer()
                    Btn_changePassword
                    Spacer()
                    Btn_deleteAccount
                }
                .background(
                    NavigationLink(
                        destination: ChangePasswordView(userProfileVM: userProfileVM), isActive: $willMoveToChangePassword)
                    {
                        EmptyView()
                    })
            }
            if isShowingPopup{
                deletePopView
            }
            if isShowingEdit{
                imagePickerView
            }

        }
        .sheet(isPresented: $imagePickerManger.showPicker) {
            ImagePicker(sourceType: imagePickerManger.source == .library ? .photoLibrary : .camera, selectedImage: $imagePickerManger.image)
                .ignoresSafeArea()
        }
        .alert("Error", isPresented: $imagePickerManger.showCameraAlert, presenting: imagePickerManger.cameraError, actions: { cameraError in
            cameraError.button
        }, message: { cameraError in
            Text(cameraError.message)
        })
        .navigationBarWithLogo()
    }
}

struct PersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView(userProfileVM: UserProfileVM(authenticator: AppManager.shared.authenticator), imagePickerManger: ImagePickerManger())
    }
}


extension PersonalInfoView{
    var top_View: some View{
        VStack{
            ContactInfoCard(userProfileVM:userProfileVM,editPhoto: {
                isShowingEdit = true
            })
            addressProfileView
        }
        .padding(.bottom)
        .background(Color.theme.bgInput)
        .appCornerRadius(18, corners: [.bottomLeft, .bottomRight])
        
    }
    
    var addressProfileView :some View{
        VStack(spacing:0){
            HStack{
                Text("Addresses")
                    .appFont(.headline)
                Spacer()
                NavigationLink {
                    AddressListView()
                } label: {
                    Text("See all")
                        .appFont(.subheadline)
                }
            }
            .foregroundColor(Color.theme.primary)
            .padding(.horizontal)
            
            // card
            if let defaultAddress = userProfileVM.userProfileData?.defaultAddress {
                AddressCard(addressModel: defaultAddress, isProfileAddress: true) {
                    //delete action
                } deleteAddressAction: {
                    //delete action
                }
                
            }
            else{
                EmptyAddressCard()
            }
        }
    }
    
    var Btn_changePassword: some View{
        AppButton(state: .constant(.normal), style:.solid(textColor: Color.theme.primary, backgroundColor: .white)) {
            
            willMoveToChangePassword = true
        } builder: {
            HStack{
                Image("password")
                Text("Change password")
                    .appFont(.headline)
            }
        }
        .padding()
        .shadow(color: Color.gray.opacity(0.3), radius: 10)
    }
    
    var Btn_deleteAccount :some View{
        AppButton(state: .constant(.normal), style: .plain) {
            isShowingPopup = true
        } builder: {
            Text("Delete account")
                .appFont(.body)
                .foregroundColor(.gray)
        }
    }
    
    var deletePopView : some View{
        ZStack{
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isShowingPopup = false
                }
            DeletePopView(
                closePopup: {isShowingPopup = false},
                content: {
                    AppTextField(data: $userProfileVM.TF_Password, placeholderText: "Password*".localized(),isSecure: true, validation: .password)
                        .padding()
                    
                    AppButton(state: $userProfileVM.changePassword_State, style: .stroke(primaryColor: .red)) {
                        userProfileVM.deleteAccount(password: userProfileVM.TF_Password.text)
                        isShowingPopup = false
                    } builder: {
                        Text("Delete account")
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.5)
                    .padding()
                },
                titel: "Delete account".localized(),
                mesaage: "By clicking delete account you will missing all data related to you, you cannot use ARBAHi or Qitaf points as payment methods. To use these features.To continue, please enter your password".localized())
            .padding()
            .frame(width: UIScreen.main.bounds.width)
        }
    }
    
    var imagePickerView : some View{
        ZStack{
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isShowingEdit = false
                }
            BottomSheetView(isOpen: $isShowingEdit, maxHeight: 300) {
                
                HStack{
                    
                    VStack(alignment: .leading) {
                        AppButton(state: .constant(.normal), style: .plain) {
                            imagePickerManger.source = .library
                            imagePickerManger.showPhotoPicker()
                        } builder: {
                            HStack{
                                Image("backgound")
                                    .overlay {
                                        Image("camera")
                                    }
                                Text("Camera")
                            }
                        }
                        AppButton(state: .constant(.normal), style:.plain) {
                            imagePickerManger.source = .camera
                            imagePickerManger.showPhotoPicker()
                        } builder: {
                            HStack{
                                Image("add")
                                Text("Gallery")
                            }
                        }
                        AppButton(state: .constant(.normal), style: .plain) {
                            print("Delete Photo")
                        } builder: {
                            HStack{
                                Image("Trash")
                                Text("Delete Photo")
                                    .foregroundColor(.red)
                            }
                        }
                    }//Vstake
                    .padding(.leading,20)
                    Spacer()
                }//Hstake
               
            }.edgesIgnoringSafeArea(.all)
        }
    }
    
}





