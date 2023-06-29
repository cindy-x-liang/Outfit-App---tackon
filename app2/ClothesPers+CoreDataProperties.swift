//
//  ClothesPers+CoreDataProperties.swift
//  
//
//  Created by Cindy Liang on 6/18/23.
//
//

import Foundation
import CoreData


extension ClothesPers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClothesPers> {
        return NSFetchRequest<ClothesPers>(entityName: "ClothesPers")
    }

    @NSManaged public var clothesType: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var imageName: Data?

}
