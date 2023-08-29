//
//  HighlightView.swift
//  QSC
//
//  Created by Zack Sai on 5/3/23.
//

import SwiftUI

// Highlights are used to display dynamic information about a project
struct HighlightView: View {
    
    // properties
    var subtitle: String
    var imageName: String
    var term: String

    // body
    var body: some View {
        ZStack() {
            
            // Image
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 216)
                .clipped()
            
            VStack{
                
                Spacer()
                
                HStack{
                    Text(subtitle)
                        .font(.caption)
                        .lineLimit(2)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
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
                    }
                }.padding(15) // end H Stack
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .background(Color(red: 37/255, green: 37/255, blue: 37/255).opacity(0.5))
                    .cornerRadius(50)
                    
            }.padding(10) // end V Stack
        } // end z stack
        .background(Color.black)
        .cornerRadius(30)
        .shadow(radius: 5)
        
    } // end body
}
