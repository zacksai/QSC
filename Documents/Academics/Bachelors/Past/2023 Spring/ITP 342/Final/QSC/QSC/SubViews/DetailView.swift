//
//  DetailView.swift
//  QSC
//
//  Created by Zack Sai on 5/3/23.
//

import SwiftUI

// view to display elements of a project
struct DetailView : View{
    
    // state and other variables
    @State private var selectedSegment = 0
    let title: String
    let subtitle: String
    let imageName: String
    let tags: String
    let term: String

    let abstractText: String
    let approachText: String
    let timelineText: String
    
    let dataText: String
    let modelText: String
    let chronologyText: String
    
    let returnText: String
    let volatilityText: String
    
    
    // body of this view
    var body: some View {
        VStack {
            // Options selector
            Picker(selection: $selectedSegment, label: Text("")) {
                Text("Abstract").tag(0)
                Text("Data").tag(1)
                Text("Results").tag(2)
                Text("Team").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 10)

            // each segment should display the appropriate info
            switch(selectedSegment){
            case 0:
                ScrollView{
                    HighlightView(subtitle: subtitle, imageName: imageName, term: term)
                        .padding(10)

                    Text("Abstract")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    Text(abstractText)
                        .font(.body)
                        .padding(10)
                    
                    Text("Approach")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    Text(approachText)
                        .font(.body)
                        .padding(10)
                    
                    Text("Timeline")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    Text(timelineText)
                        .font(.body)
                        .padding(10)

                }
            case 1:
                ScrollView{
                    ProfileView(subtitle: "Data from DOA scraped, cleaned and analyzed using Python.", imageName: "data")
                        .padding(10)

                    Text("Data")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    Text(dataText)
                        .font(.body)
                        .padding(10)
                    
                    Text("Models")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    Text(modelText)
                        .font(.body)
                        .padding(10)
                    
                    Text("Chronology")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    Text(chronologyText)
                        .font(.body)
                        .padding(10)
                    
                }
            case 2:
                ScrollView{
                    
                    // image view
                    Image("theta_test_scaled")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 216)
                        .clipped()

                    Text("Return")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    Text(returnText)
                        .font(.body)
                        .padding(10)
                    
                    Text("Volatility")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(10)
                    Text(volatilityText)
                        .font(.body)
                        .padding(10)
                    

                }
            case 3:
                ScrollView{
                    
                    ProfileView(subtitle: "Zack Sai: Project Manager", imageName: "headshot")
                    ProfileView(subtitle: "Megan Wang: Model Team", imageName: "megan")
                    ProfileView(subtitle: "Anish Jayant: Model Team", imageName: "anish")
                    ProfileView(subtitle: "Haobin Cao: Model Team", imageName: "haobin")
                    ProfileView(subtitle: "Tom Watson: Data Team", imageName: "tom")
                    ProfileView(subtitle: "Charles Lee: Data Team", imageName: "charles")
                    
                }
            default: Text("Error")
            }

            Spacer()
        }
        .navigationBarTitle(Text(title), displayMode: .inline)
        .padding(.horizontal, 20)
    }
}
