//
//  Projects.swift
//  QSC App
//
//  Created by Zack Sai on 4/25/23.
//

import Foundation

class Project: Codable, Identifiable {
    
    // properties
    let id: UUID
    var title: String
    var subtitle: String
    var term: String
    var tags: String
    
    // long text
    var abstractText: String
    var approachText: String
    var timelineText: String
    
    var dataText: String
    var modelText: String
    var chronologyText: String
    
    var returnText: String
    var volatilityText: String
//    var contributors: [Contributor]
    
    // coding keys
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case term
        case tags
        
        case abstractText
        case approachText
        case timelineText
        
        case dataText
        case modelText
        case chronologyText
        
        case returnText
        case volatilityText
//        case contributors
    }

    // conform to decodable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        term = try container.decode(String.self, forKey: .term)
        tags = try container.decode(String.self, forKey: .tags)
        
        abstractText = try container.decode(String.self, forKey: .abstractText)
        approachText = try container.decode(String.self, forKey: .approachText)
        timelineText = try container.decode(String.self, forKey: .timelineText)
        
        dataText = try container.decode(String.self, forKey: .dataText)
        modelText = try container.decode(String.self, forKey: .modelText)
        chronologyText = try container.decode(String.self, forKey: .chronologyText)

        returnText = try container.decode(String.self, forKey: .returnText)
        volatilityText = try container.decode(String.self, forKey: .volatilityText)
//        contributors = try container.decode([Contributor].self, forKey: .contributors)
    }
    
    
    
}
