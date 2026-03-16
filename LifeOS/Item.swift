//
//  Item.swift
//  LifeOS
//
//  Created by Ajith Pepi Anbu Selvan on 16/03/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
