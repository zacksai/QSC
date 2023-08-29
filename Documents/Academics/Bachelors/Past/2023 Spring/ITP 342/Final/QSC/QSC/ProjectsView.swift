//
//  ContentView.swift
//  QSC_App
//
//  Created by Zack Sai on 4/11/23.
//

import SwiftUI
import Foundation


// primary view
struct ProjectsView: View {
    
    // states variables for tabs
    @State private var selectedTab = "Home"
    @State private var selectedSegment = 0
    
    // Get shared instance of ProjectData
    @StateObject private var projectsManager = ProjectsManager()
    
    
    
    // body of the screen
    var body: some View {

        // Home and Search
        TabView(selection: $selectedTab) {
            
            // Navigation w/ Segmented Picker
            NavigationView {
                
                // Stack elements vertically
                VStack {
                    
                    // Title
                    Text("Projects")
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Seg Picker
                    Picker(selection: $selectedSegment, label: Text("")) {
                        Text("List").tag(0)
                        Text("By Semester").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10)

                    
                    // Scroller
                    ScrollView {
                        VStack(spacing: 20) {
                            
                            if selectedSegment == 1 {
                                Text("Spring 2023")
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 10)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            // set image names
                            let imageNames = ["agri", "insider", "sports", "kalshi"]
                            
                            // intialize each card
                            ForEach(projectsManager.projects.indices, id: \.self) {index in
                                let project = projectsManager.projects[index]
                                CardView(title: project.title, subtitle: project.subtitle, imageName: imageNames[index % imageNames.count], tags: project.tags, term: project.term, abstractText: project.abstractText, approachText: project.approachText, timelineText: project.timelineText, dataText: project.dataText, modelText: project.modelText, chronologyText: project.chronologyText, returnText: project.returnText, volatilityText: project.volatilityText)
                            }
                        }
                        .padding(10)
                    }
                    
                }
                .navigationBarTitle("Agricultural Options")
                .navigationBarHidden(true)
                .padding(.horizontal, 20)
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag("Home")
            // End home tab item
            
            Text("Search View")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag("Search")
        }
        .onAppear(perform: projectsManager.loadData) // load data on appear
    }
}

// preview to help with designing
struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()

    }
}
