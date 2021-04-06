//
//  CoreDataManager.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Reign")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveNews (newsArray: [News]) {
        let context = persistentContainer.viewContext
        
        for news in newsArray {
            let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "News", into: context)
            newsEntity.setValue(news.author, forKey: NewsKeys.author.rawValue)
            newsEntity.setValue(news.created_at, forKey: NewsKeys.created_at.rawValue)
            newsEntity.setValue(news.story_id, forKey: NewsKeys.story_id.rawValue)
            newsEntity.setValue(news.story_url, forKey: NewsKeys.story_url.rawValue)
            newsEntity.setValue(news.story_title, forKey: NewsKeys.story_title.rawValue)
            newsEntity.setValue(news.title, forKey: NewsKeys.title.rawValue)
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
