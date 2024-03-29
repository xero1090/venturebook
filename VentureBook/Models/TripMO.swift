//
//  TripMO.swift
//  VentureBook
//
//  Group 4
//  Michael Kempe, 991 566 501
//  Kevin Tran, 991 566 232
//  Anh Phan, 991 489 221
//
//  Created by Michael Kempe on 2021-10-31.
//

import Foundation
import CoreData

@objc(TripMO)
final class TripMO: NSManagedObject{
    @NSManaged var id: UUID?
    @NSManaged var title: String
    @NSManaged var created: Date
}

extension TripMO{
    func convertToTrip() -> Trip{
        return Trip(id: id ?? UUID(), title: title, created: created)
    }
}
