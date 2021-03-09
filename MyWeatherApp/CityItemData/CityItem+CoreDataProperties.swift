//
//  CityItem+CoreDataProperties.swift
//  
//
//  Created by Rami Moubayed on 09/03/2021.
//
//

import Foundation
import CoreData


extension CityItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityItem> {
        return NSFetchRequest<CityItem>(entityName: "CityItem")
    }

    @NSManaged public var name: String?

}
