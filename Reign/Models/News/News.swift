//
//  News.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation
import CoreData

typealias NewsKeys = News.CodingKeys

class NewsHolder: Codable {
    var hits: [News]?
}

class News: NSObject, Codable {
    
    var author: String?
    var created_at: String?
    var object_id: String?
    var story_title: String?
    var story_url: String?
    var title: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case created_at = "created_at"
        case object_id = "objectID"
        case object_id_core_data = "object_id"
        case story_title = "story_title"
        case story_url = "story_url"
        case title = "title"
        case url = "url"
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = try? container.decodeIfPresent(String.self, forKey: .author)
        created_at = try? container.decodeIfPresent(String.self, forKey: .created_at)
        object_id = try? container.decodeIfPresent(String.self, forKey: .object_id)
        story_title = try? container.decodeIfPresent(String.self, forKey: .story_title)
        story_url = try? container.decodeIfPresent(String.self, forKey: .story_url)
        title = try? container.decodeIfPresent(String.self, forKey: .title)
        url = try? container.decodeIfPresent(String.self, forKey: .url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(author, forKey: .author)
        try container.encodeIfPresent(created_at, forKey: .created_at)
        try container.encodeIfPresent(object_id, forKey: .object_id_core_data)
        try container.encodeIfPresent(story_title, forKey: .story_title)
        try container.encodeIfPresent(story_url, forKey: .story_url)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(url, forKey: .url)
    }
}
