//
//  ItemList+CoreDataProperties.swift
//  News
//
//  Created by Pedro Capela on 31/05/2021.
//
//

import Foundation
import CoreData


extension ItemList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemList> {
        return NSFetchRequest<ItemList>(entityName: "ItemList")
    }

    @NSManaged public var desc: String?
    @NSManaged public var done: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension ItemList : Identifiable {

}
