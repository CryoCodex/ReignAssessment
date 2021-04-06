//
//  News.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation
import CoreData

typealias NewsKeys = News.CodingKeys

class NewsHolder: Decodable {
    var hits: [News]?
}

class News: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case created_at = "created_at"
        case story_id = "story_id"
        case story_title = "story_title"
        case story_url = "story_url"
        case title = "title"
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else { throw CodableErrors.missingManagedObjectContext }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        author = (try? container.decodeIfPresent(String.self, forKey: .author)) ?? ""
        created_at = (try? container.decodeIfPresent(String.self, forKey: .created_at)) ?? ""
        story_id = (try? container.decodeIfPresent(Int32.self, forKey: .story_id)) ?? 0
        story_title = (try? container.decodeIfPresent(String.self, forKey: .story_title)) ?? ""
        story_url = (try? container.decodeIfPresent(String.self, forKey: .story_url)) ?? ""
        title = (try? container.decodeIfPresent(String.self, forKey: .title)) ?? ""
    }
    
}
