//
//  FavoriteProvider.swift
//  RAWG
//
//  Created by Azis on 23/10/20.
//  Copyright © 2020 Stay At Home ID. All rights reserved.
//

import CoreData
import UIKit

class FavoriteProvider {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favorite")
        
        container.loadPersistentStores { storeDesription, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getAll(completion: @escaping(_ members: [FavoriteModel]) -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var favorites: [FavoriteModel] = []
                for result in results {
                    let favorite = FavoriteModel(id: result.value(forKeyPath: "id") as? Int32,
                                                genres: result.value(forKeyPath: "genres") as? String,
                                                name: result.value(forKeyPath: "name") as? String,
                                                rating: result.value(forKeyPath: "rating") as? Float,
                                                ratingsCount: result.value(forKeyPath: "ratings_count") as? Int32,
                                                backgroundImage: result.value(forKeyPath: "background_image") as? String,
                                                released: result.value(forKeyPath: "released") as? Date)
                    favorites.append(favorite)
                }
                completion(favorites)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func get(_ id: Int, completion: @escaping(_ favorite: FavoriteModel) -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first{
                    let favorite = FavoriteModel(id: result.value(forKeyPath: "id") as? Int32,
                                                genres: result.value(forKeyPath: "genres") as? String,
                                                name: result.value(forKeyPath: "name") as? String,
                                                rating: result.value(forKeyPath: "rating") as? Float,
                                                ratingsCount: result.value(forKeyPath: "ratings_count") as? Int32,
                                                backgroundImage: result.value(forKeyPath: "background_image") as? String,
                                                released: result.value(forKeyPath: "released") as? Date)
                    completion(favorite)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func create(_ id: Int32, _ genres: String, _ name: String, _ rating: Float, _ ratingsCount: Int32, _ backgroundImage: String, _ released: Date, completion: @escaping() -> ()){
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: taskContext) {
                let favorite = NSManagedObject(entity: entity, insertInto: taskContext)
                favorite.setValue(id, forKeyPath: "id")
                favorite.setValue(genres, forKeyPath: "genres")
                favorite.setValue(name, forKeyPath: "name")
                favorite.setValue(rating, forKeyPath: "rating")
                favorite.setValue(ratingsCount, forKeyPath: "ratings_count")
                favorite.setValue(backgroundImage, forKeyPath: "background_image")
                favorite.setValue(released, forKeyPath: "released")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func update(_ id: Int32, _ genres: String, _ name: String, _ rating: Float, _ ratingsCount: Int32, _ backgroundImage: String, _ released: Date, completion: @escaping() -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            if let result = try? taskContext.fetch(fetchRequest), let favorite = result.first as? Favorite{
                favorite.setValue(genres, forKeyPath: "genres")
                favorite.setValue(name, forKeyPath: "name")
                favorite.setValue(rating, forKeyPath: "rating")
                favorite.setValue(ratingsCount, forKeyPath: "ratings_count")
                favorite.setValue(backgroundImage, forKeyPath: "background_image")
                favorite.setValue(released, forKeyPath: "released")
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func getMaxId(completion: @escaping(_ maxId: Int) -> ()) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.fetchLimit = 1
            do {
                let lastMember = try taskContext.fetch(fetchRequest)
                if let member = lastMember.first, let position = member.value(forKeyPath: "id") as? Int{
                    completion(position)
                } else {
                    completion(0)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteAll(completion: @escaping() -> ()) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completion()
            }
        }
    }
    
    func delete(_ id: Int, completion: @escaping() -> ()){
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
                batchDeleteResult.result != nil {
                completion()
            }
        }
    }
}
