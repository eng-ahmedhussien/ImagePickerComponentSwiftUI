# SwiftUI Image Picker Component

## Description:

This SwiftUI component allows users to pick an image from either the photo library or camera.
It provides easy integration with your SwiftUI app through a simple interface.
Users can also edit the chosen image before selecting it.

## Features:

Select images from photo library or camera
Image editing option
Returns selected image through a Binding variable
Easy SwiftUI integration

## Usage:

Import the ImagePicker struct in your SwiftUI view.
Set the source type (photoLibrary or camera) using the sourceType property.
Bind the selected image to a variable in your view using the @Binding var selectedImage: UIImage? property.
Use the ImagePicker as a view in your SwiftUI layout.

# Image Picker Manger 

## Description:

This class provides a simple and easy-to-use way to manage image selection from the camera or photo library in your iOS app. It handles permission checks, error handling, and provides user feedback.

## Features:

Choose images from camera or photo library.
Automatic permission checks and error handling.
Clear user feedback through alerts and buttons.
Currently supports basic image selection without editing.

## Getting Started:

Add the ImagePickerManger.swift file to your project.
Create an instance of ImagePickerManger in your view controller.
Bind the image property to your UI element to display the selected image.
Use the showPhotoPicker function to present the image picker.

## Example:

<img width="251" alt="Screenshot 2024-02-22 at 10 15 23 AM" src="https://github.com/eng-ahmedhussien/bottomPopImagePickerViewTaskSwiftUi/assets/33827384/02b50de9-7320-473b-b382-8dbb548a948f">
