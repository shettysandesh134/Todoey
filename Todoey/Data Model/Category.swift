//
//  Category.swift
//  Todoey
//
//  Created by Sandesh Shetty on 3/7/18.
//  Copyright © 2018 Sandesh Shetty. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
