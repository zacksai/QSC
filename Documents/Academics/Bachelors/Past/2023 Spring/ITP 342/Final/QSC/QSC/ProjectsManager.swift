//
//  ProjectsManager.swift
//  QSC
//
//  Created by Zack Sai on 5/3/23.
//

import Foundation

class ProjectsManager: ObservableObject{
    
    // shared instance
    @Published var projects: [Project] = []
    
    // use for data persistence
    private let projectsKey = "projects"
    
    // api call to load data
    func loadData() {
        
        // first check for previous data:
        let loadedProjects = loadProjectsFromPersistence()
            
        if !loadedProjects.isEmpty {
            self.projects = loadedProjects
            return
        }
        
        // store API info
        let apiKey = "AIzaSyApXsBcSfPWHmgoP4MwKYcAbN_ojqRDc58"
        let sheetId = "1zQ8gvIVqN16lcNdFOvu9swvBmKY-qJyH3GjcTLBHhC0"
        let sheetRange = "Sheet1!A2:L5"
        let urlString = "https://sheets.googleapis.com/v4/spreadsheets/\(sheetId)/values/\(sheetRange)?key=\(apiKey)"

        // Safely create URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Make request
        URLSession.shared.dataTask(with: url) { data, _, _ in
            
            // ensure returned data is non nil
            if let data = data {
                do {
                    
                    // make dictionary from data returned
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                    // confirm "values" key is present
                    if let values = json?["values"] as? [[String]] {
                        
                        // temporary storage
                        var loadedProjects: [Project] = []

                        // iterate through each row and make a project
                        values.forEach { projectData in
                            guard projectData.count >= 4 else { return }

                            // Create dictionary
                            let projectDict: [String: String] = [
                                "title": projectData[0],
                                "subtitle": projectData[1],
                                "term": projectData[2],
                                "tags": projectData[3],
                                
                                "abstractText": projectData[4],
                                "approachText": projectData[5],
                                "timelineText": projectData[6],
                                
                                "dataText": projectData[7],
                                "modelText": projectData[8],
                                "chronologyText": projectData[9],
                                
                                "returnText": projectData[10],
                                "volatilityText": projectData[11]
                            ]

                            // initialize project using decoded data
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: projectDict, options: [])
                                let project = try JSONDecoder().decode(Project.self, from: jsonData)
                                
                                // add to temp storage
                                loadedProjects.append(project)
                                
                            
                            } catch { // handle error
                                print("Failed to decode project data: \(error)")
                            }
                        }
                        DispatchQueue.main.async {
                            // update UI on main thread
                            self.projects = loadedProjects
                            self.saveProjects() // update data persistence
                        }
                    }
                } catch { // handle errors
                    print("Failed to load data")
                }
            } else {
                print("No data received")
            }
        }.resume() // begin task
        
//        print("finished loading data")

    }
    
    // add data persistence

    // save projects to user defaults
    private func saveProjects() {
        do {
            let data = try JSONEncoder().encode(projects)
            UserDefaults.standard.set(data, forKey: projectsKey)
        } catch {
            print("Error saving projects: \(error)")
        }
    }

    // load from user defaults
    private func loadProjectsFromPersistence() -> [Project] {
        if let data = UserDefaults.standard.data(forKey: projectsKey) {
            do {
                let loadedProjects = try JSONDecoder().decode([Project].self, from: data)
                return loadedProjects
            } catch {
                print("Error loading projects from persistence: \(error)")
            }
        }
        return []
    }
}
