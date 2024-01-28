//
//  ImagePicker.swift
//  Created by ahmed hussien on 13/08/2023.
//

import UIKit
import SwiftUI
import AVFoundation



class ImagePickerManger:ObservableObject{
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: PickerSource.Source = .library
    @Published var showCameraAlert = false
    @Published var cameraError: PickerSource.CameraErrorType?
    
    func showPhotoPicker() {
        do {
            if source == .camera {
                try PickerSource.checkPermissions()
            }
            showPicker = true
        } catch {
            showCameraAlert = true
            cameraError = PickerSource.CameraErrorType(error: error as! PickerSource.PickerError)
        }
    }
}

enum PickerSource {
    enum Source: String {
        case library, camera
    }
    
    enum PickerError: Error, LocalizedError {
        case unavailable
        case restricted
        case denied
        
        var errorDescription: String? {
            switch self {
            case .unavailable:
                return NSLocalizedString("There is no available camera on this device", comment: "")
            case .restricted:
                return NSLocalizedString("You are not allowed to access media capture devices.", comment: "")
            case .denied:
                return NSLocalizedString("You have explicitly denied permission for media capture. Please open permissions/Privacy/Camera and grant access for this application.", comment: "")
            }
        }
    }
    
    static func checkPermissions() throws {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .denied:
                throw PickerError.denied
            case .restricted:
                throw PickerError.restricted
            default:
                break
            }
        } else {
            throw PickerError.unavailable
        }
    }
    
    struct CameraErrorType {
        let error: PickerSource.PickerError
        var message: String {
            error.localizedDescription
        }
        let button =  Button {
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        } label: {
            Text("ok")
        }
 //Button("OK", role: .cancel) {}
    }
}
