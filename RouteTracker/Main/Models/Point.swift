//
//  Point.swift
//  RouteTracker
//
//  Created by Nikita Sergeyev on 16.11.2021.
//

import Foundation
import RealmSwift

class Point: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
}
