//
//  ProfileView.swift
//  QSC
//
//  Created by Zack Sai on 5/3/23.
//

import SwiftUI
import ContactsUI

// profile view is used to display a project contributor's profile
struct ProfileView: View {
    
    // properties
    var subtitle: String
    var imageName: String
    @State private var isShowingContactPicker = false

    // body of the view
    var body: some View {
        ZStack() {
            
            // Image
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 216)
                .clipped()
                .cornerRadius(30)
            
            VStack{
                
                Spacer()
                
                HStack{
                    Text(subtitle)
                        .font(.caption)
                        .lineLimit(2)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }.padding(15) // end H Stack
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .background(Color(red: 37/255, green: 37/255, blue: 37/255).opacity(0.5))
                    .cornerRadius(50)
                    .onTapGesture {
                        isShowingContactPicker = true
                    }
                    .sheet(isPresented: $isShowingContactPicker) {
                        ContactPicker(subtitle: subtitle)
                    }
                    
            }.padding(10) // end V Stack
        } // end z stack
        .background(Color.black)
        .cornerRadius(30)
        .shadow(radius: 5)
        
    } // end body
}

// view that presents a contact picker and creates a new contact
struct ContactPicker: UIViewControllerRepresentable {
    
    // The subtitle to use for the new contact's first name
    var subtitle: String

    // Create a coordinator for the view
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Create the contact picker view controller
    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let contactPickerViewController = CNContactPickerViewController()
        
        // Set the coordinator as the delegate for the contact picker view controller
        contactPickerViewController.delegate = context.coordinator
        
        return contactPickerViewController
    }

    // Update the view controller when necessary
    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {
    }

    // Define a coordinator class that acts as the delegate for the contact picker view controller
    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPicker

        // Initialize the coordinator with the parent view
        init(_ parent: ContactPicker) {
            self.parent = parent
        }

        // Called when a contact is selected
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
            // Get the selected contact
            let contact = contactProperty.contact
            
            // Create a new mutable contact
            let newContact = CNMutableContact()
            
            // Set the first name of the new contact to the provided subtitle
            newContact.givenName = parent.subtitle
            
            // Set the last name of the new contact to the same last name as the selected contact
            newContact.familyName = contact.familyName
            
            // Create a save request for the new contact
            let saveRequest = CNSaveRequest()
            saveRequest.add(newContact, toContainerWithIdentifier: nil)
            
            // Get the contact store and attempt to save the new contact
            let store = CNContactStore()
            do {
                try store.execute(saveRequest)
            } catch {
                print("Error adding contact: \(error)")
            }
        }
    }
}
