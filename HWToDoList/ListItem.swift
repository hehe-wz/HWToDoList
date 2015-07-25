//
//  ListItem.swift
//  HWToDoList
//
//  Created by Zun Wang on 7/23/15.
//  Copyright (c) 2015 ZW. All rights reserved.
//

import UIKit

class ListItem: NSObject {
  var name : String
  var dueDate : NSDate
  var needRemind : Bool
  
  init(name: String, dueDate: NSDate, needRemind: Bool) {
    self.name = name
    self.dueDate = dueDate
    self.needRemind = needRemind
  }
}
