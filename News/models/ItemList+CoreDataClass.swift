//
//  ItemList+CoreDataClass.swift
//  News
//
//  Created by Pedro Capela on 31/05/2021.
//
//

import Foundation
import CoreData

enum DoneItemList {
    case done
    case inProgress
    case toDo
    
    func toString() -> String {
        if self == DoneItemList.done {
            return "done"
        }else if self == DoneItemList.toDo{
            return "toDo"
        }else{
            return "inProgress"
        }
    }
    
    func getPresentationString() -> String{
        if self == DoneItemList.done {
            return "Done".localized()
        }else if self == DoneItemList.toDo{
            return "To-do".localized()
        }else{
            return "In Progress".localized()
        }
    }
}

@objc(ItemList)
public class ItemList: NSManagedObject {
    class func addItem(id: String, name: String, desc: String, inManagedObjectContext  context:NSManagedObjectContext) -> ItemList?{
        if let itemList = NSEntityDescription.insertNewObject(forEntityName: "ItemList", into: context) as? ItemList{
            itemList.id = id
            itemList.name = name
            itemList.done = DoneItemList.toDo.toString()
            itemList.desc = desc
            
            return itemList
        }
        
        return nil
    }
    
    class func updateItem(id:String, name: String, desc: String, state: DoneItemList, inManagedObjectContext  context:NSManagedObjectContext) -> ItemList?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemList")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let itemList = (try? context.fetch(request).first as? ItemList){
            itemList.id = id
            itemList.name = name
            itemList.done = state.toString()
            itemList.desc = desc
            
            return itemList
        }
        
        return nil
    }
    
    class func getItem(id:String, inManagedObjectContext  context:NSManagedObjectContext) -> ItemList?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemList")
        request.predicate = NSPredicate(format: "id = %@", id)
        
        if let itemList = (try? context.fetch(request).first as? ItemList){
            return itemList
        }
        
        return nil
    }
    
    class func removeItem(id:String, inManagedObjectContext  context:NSManagedObjectContext) -> Bool{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemList")
        request.predicate = NSPredicate(format: "id = %@", id)
        if let itemList = (try? context.fetch(request))?.first as? ItemList {
            context.delete(itemList)
            return true
        }
        
        return false
    }
    
    class func getAllItems(inManagedObjectContext  context:NSManagedObjectContext) -> [ItemList]?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemList")
                
        if let itemsList = (try? context.fetch(request)) as? [ItemList] {
            return itemsList
        }
        
        return nil
    }
}
