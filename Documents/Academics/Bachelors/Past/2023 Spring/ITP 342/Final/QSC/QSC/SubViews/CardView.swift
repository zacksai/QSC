//
//  CardView.swift
//  QSC
//
//  Created by Zack Sai on 5/3/23.
//

import SwiftUI
import MessageUI

// "Cards" are used to display a preview of a project
struct CardView: View {
    
    @State private var isShowingMessageComposer = false
    @State private var isShowingAlert = false

    var title: String
    var subtitle: String
    var imageName: String
    var tags: String
    var term: String

    var abstractText: String
    var approachText: String
    var timelineText: String
    
    var dataText: String
    var modelText: String
    var chronologyText: String
    
    var returnText: String
    var volatilityText: String

    // body of a card should navigate into the detail view
    var body: some View {
        NavigationLink(destination: DetailView(title: title, subtitle: subtitle, imageName: imageName, tags: tags, term: term, abstractText: abstractText, approachText: approachText, timelineText: timelineText, dataText: dataText, modelText: modelText, chronologyText: chronologyText, returnText: returnText, volatilityText: volatilityText)) {
            
            
            VStack(spacing: 0) {
                
                // Image
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 109)
                    .clipped()
                
                // L and R
                HStack{
                    GeometryReader{
                        geom in
                        
                        // LEFT: Title, subtitle, tags
                        VStack{
                            
                            // Title
                            Text(title)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .kerning(0.37)
                            
                            
                            // Subtitle
                            Text(subtitle)
                                .font(.caption2)
                                .fontWeight(.light)
                                .lineLimit(3)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .kerning(0.37)
                            
                            Spacer()
                            // RIGHT: tag image, tags
                            HStack{
                                // tag image
                                Image(systemName: "tag")
                                    .foregroundColor(Color.gray)
                                    .font(.caption2)
                                
                                // tag text
                                Text(tags.lowercased())
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)                            .frame(maxWidth: .infinity, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(width: .infinity, alignment: .leading)
                            
                        } // end left
                        .frame(width: geom.size.width * 7/10, alignment: .leading)
                        
                        
                        
                        // RIGHT: button, date
                        VStack{
                            // Share Button
                            Button(action: {
                                let messageComposer = MessageComposer(title: title, subtitle: subtitle)
                                if messageComposer.canSendText {
                                    isShowingMessageComposer = true
                                } else {
                                    isShowingAlert = true
                                }
                            }) {
                                Text("Share")
                                    .font(.callout)
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.bold)
                                    .padding(10)
                            }
                            .buttonStyle(DefaultButtonStyle())
                            .background(Color(red: 0.854, green: 0.921, blue: 0.999))
                            .cornerRadius(100)
                            .shadow(radius: 2)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .sheet(isPresented: $isShowingMessageComposer) {
                                MessageComposer(title: title, subtitle: subtitle)
                            }
                            .alert(isPresented: $isShowingAlert) {
                                Alert(title: Text("Cannot Send Text Message"), message: Text("Your device is not capable of sending text messages."), dismissButton: .default(Text("OK")))
                            }
                            Spacer()
                            
                            // Date and chevron
                            HStack{
                                
                                // Date
                                Text(term.lowercased())
                                    .font(.caption2)
                                    .fontWeight(.thin)
                                
                                
                                // chevron
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.gray)
                                    .font(.caption)
                            }.frame(maxWidth: .infinity, alignment: .trailing)
                            
                        } // end right
                        
                    } // end geom reader
                    
                }.padding() // end hstack
                
                
            } // end v stack
            .aspectRatio(1.5, contentMode: .fit)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 5)
            
            
        }
    } // end body
    
}


//view that presents a message composer for sending text messages
struct MessageComposer: UIViewControllerRepresentable {
    
    // The title and subtitle to include in the message body
    var title: String
    var subtitle: String
    
    // Whether the device is capable of sending text messages
    var canSendText: Bool

    // Initialize the view with the title and subtitle
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        
        // Check if the device can send text messages
        self.canSendText = MFMessageComposeViewController.canSendText()
    }

    // Create a coordinator for the view
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Create the message composer view controller
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let messageComposeViewController = MFMessageComposeViewController()
        
        // Set the coordinator as the delegate for the message composer view controller
        messageComposeViewController.messageComposeDelegate = context.coordinator
        
        // Set the message body to include the provided title and subtitle
        messageComposeViewController.body = "Title: \(title)\nSubtitle: \(subtitle)"
        
        return messageComposeViewController
    }

    // Update the view controller when necessary
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {
    }

    // Define a coordinator class that acts as the delegate for the message composer view controller
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var parent: MessageComposer
        
        // Initialize the coordinator with the parent view
        init(_ parent: MessageComposer) {
            self.parent = parent
        }
        
        // Called when the user finishes composing a message
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            // Dismiss the message composer view controller
            controller.dismiss(animated: true)
        }
    }
}
