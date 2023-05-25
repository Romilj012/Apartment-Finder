//
//  ApartmentEditView.swift
//  ApartmentFinder
//
//  Created by Hasnain Ahmed Shaikh on 3/31/23.
//

import SwiftUI
import PhotosUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

struct ApartmentEditView: View {
    @EnvironmentObject var viewModel:AppViewModel
    @State private var description = ""
    @State private var address = ""
    @State private var price = 0
    @State private var images = [UIImage]()
    @State private var imagePath = ""
    
    @State private var isShowingImagePicker = false
    @State private var isShowingImagePickerError = false
    @State private var isShowingAlert = false // Added alert state
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Apartment Details")) {
                    TextField("Description", text: $description)
                    TextField("Address", text: $address)
                    Picker("Price", selection: $price) {
                        Text("$500").tag(500)
                        Text("$1000").tag(1000)
                        Text("$1500").tag(1500)
                    }
                }
                
                Section {
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(images, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                    
                    Button(action: {
                        isShowingImagePicker = true
                    }) {
                        Text("Choose Images")
                    }
                    .foregroundColor(.blue)
                    .alert(isPresented: $isShowingImagePickerError) {
                        Alert(title: Text("Error"), message: Text("You must select at least one image."), dismissButton: .default(Text("OK")))
                    }
                }
                
                Button("Add Listing") {
                    if images.isEmpty {
                        isShowingImagePickerError = true // Show error alert
                        return
                    }
                    print("hfghghgh")
                    //print(images)
                    let data = images[0].jpegData(compressionQuality: 0.8)!
                    @EnvironmentObject var viewModel:AppViewModel
                    let time = Date().timeIntervalSince1970
                    let filePath = "\(self.viewModel.userName)/\(time).jpg"
                    
                    let storage = Storage.storage()
                    let storageRef = storage.reference()
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpeg"
                    let ref = storageRef.child(filePath)
                    ref.putData(data,metadata: metadata){
                        m,e in
                        if e == nil {
                            //let db = Firestore.firestore()
                            //db.collection("apartments").document().setData(["images":filePath])
                        }
                    }
                    self.viewModel.addApartment(description: description, address: address, price: String(price), images: [filePath])
                    
                    isShowingAlert = true // Show success alert
                }
            }.navigationBarTitle("Add Apartment")
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImages) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$images)
                }.environmentObject(self.viewModel)
        }
        .alert(isPresented: $isShowingAlert) { // Success alert
            Alert(title: Text("Listing Added"), message: Text("Listing has been successfully added."), dismissButton: .default(Text("OK")))
        }
    }
    
    func compressImage(_ image: UIImage) -> Data? {
        let compressionQuality: CGFloat = 0.5 // adjust this as needed
        return image.jpegData(compressionQuality: compressionQuality)
    }

    func loadImages() {
        // Do nothing, since the selected images are already stored in the `images` state variable
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var selectedImage: [UIImage]

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage.append(image)
            }
            
            //print(parent.selectedImage)
            //var data = NSData()
            
            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}

struct ApartmentEditView_Previews: PreviewProvider {
    static var previews: some View {
        ApartmentEditView()
    }
}


