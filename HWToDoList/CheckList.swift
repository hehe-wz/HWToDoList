//
//  CheckList.swift
//  HWToDoList
//
//  Created by Zun Wang on 7/23/15.
//  Copyright (c) 2015 ZW. All rights reserved.
//

import UIKit

class CheckList: NSObject {
  let name : String
  let icon : UIImage?
  var itemList : [ListItem]
  
  init(name: String, icon: UIImage?) {
    self.name = name
    self.icon = icon
    itemList = [ListItem]()
  }
}
