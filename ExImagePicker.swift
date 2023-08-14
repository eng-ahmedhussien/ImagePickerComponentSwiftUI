
import SwiftUI

struct PersonalInfoView: View {  
    @State private var isShowingEdit = false
    @StateObject var imagePickerManger: ImagePickerManger
    
    init(imagePickerManger :ImagePickerManger ) {
        _imagePickerManger = StateObject(wrappedValue: imagePickerManger)
    }
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
              AppButton(state: .constant(.normal), style:.solid(textColor: Color.theme.primary, backgroundColor: .white)) {
                  isShowingEdit = true
                 } builder: {
                      HStack{
                      Text("edite")
                    .appFont(.headline)
                    }
                  }
                }
            }
            if isShowingEdit{
                imagePickerView
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
        PersonalInfoView(imagePickerManger: ImagePickerManger())
    }
}


extension PersonalInfoView{ 
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





