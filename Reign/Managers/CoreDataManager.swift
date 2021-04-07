//
//  CoreDataManager.swift
//  Reign
//
//  Created by Neptali Duque on 4/6/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    enum Containers: String {
        case reign = "Reign"
    }
    
    enum Entities: String {
        case managedNews = "ManagedNews"
    }
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Containers.reign.rawValue)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return container
    }()

    // MARK: - Core Data News Operations
    func saveNews (newsArray: [News]) {
        let context = persistentContainer.viewContext
        
        for news in newsArray {
            let newsEntity = NSEntityDescription.insertNewObject(forEntityName: Entities.managedNews.rawValue, into: context)
            newsEntity.setValue(news.author, forKey: NewsKeys.author.rawValue)
            newsEntity.setValue(news.created_at, forKey: NewsKeys.created_at.rawValue)
            newsEntity.setValue(news.object_id, forKey: NewsKeys.object_id_core_data.rawValue)
            newsEntity.setValue(news.story_url, forKey: NewsKeys.story_url.rawValue)
            newsEntity.setValue(news.story_title, forKey: NewsKeys.story_title.rawValue)
            newsEntity.setValue(news.title, forKey: NewsKeys.title.rawValue)
            newsEntity.setValue(news.url, forKey: NewsKeys.url.rawValue)
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
    
    func getNews() -> [News] {
        var newsArray: [News] = []
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entities.managedNews.rawValue)
        
        do {
            let unprocessedArray = try context.fetch(fetchRequest)
            for item in unprocessedArray {
                let news = News()
                news.author = item.value(forKey: NewsKeys.author.rawValue) as? String
                news.created_at =  item.value(forKey: NewsKeys.created_at.rawValue) as? String
                news.object_id = item.value(forKey: NewsKeys.object_id_core_data.rawValue) as? String
                news.story_url = item.value(forKey: NewsKeys.story_url.rawValue) as? String
                news.story_title = item.value(forKey: NewsKeys.story_title.rawValue) as? String
                news.title = item.value(forKey: NewsKeys.title.rawValue) as? String
                news.url = item.value(forKey: NewsKeys.url.rawValue) as? String
                newsArray.append(news)
            }
            
            newsArray.sort { $0.created_at ?? "" >= $1.created_at ?? "" }
            return newsArray
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return newsArray
        }
    }
    
    func deleteNews(listViewModel: ListViewModel) {
        let context = persistentContainer.viewContext
        let objectId = listViewModel.id
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entities.managedNews.rawValue)
        fetchRequest.predicate = NSPredicate(format: "object_id = %@", argumentArray: [objectId])
        
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }

}
