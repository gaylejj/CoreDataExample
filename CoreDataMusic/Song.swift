//
//  Song.swift
//  CoreDataMusic
//
//  Created by Jeff Gayle on 8/19/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

import Foundation
import CoreData

class Song: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var year: NSNumber
    @NSManaged var artist: Artist

}
