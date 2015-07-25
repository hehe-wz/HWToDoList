//
//  IconListTableVC.swift
//  HWToDoList
//
//  Created by Zun Wang on 7/23/15.
//  Copyright (c) 2015 ZW. All rights reserved.
//

import UIKit

class IconListTableVC: UITableViewController {
  let iconNameList = ["No Icon", "Appointments", "Birthdays", "Chores", "Drinks"]
  let editDelegate: EditCheckListIconDelegate
  
  init(editDelegate: EditCheckListIconDelegate) {
    self.editDelegate = editDelegate
    super.init(nibName:nil, bundle:nil)
  }

  required init!(coder aDecoder: NSCoder!) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Choose Icon"
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return iconNameList.count;
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = self.tableView.dequeueReusableCellWithIdentifier("IconListTableViewCell") as? UITableViewCell
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "IconListTableViewCell")
    }
    
    let iconName = iconNameList[indexPath.row]
    cell!.imageView?.image = UIImage(named: iconName)
    cell!.textLabel?.text = iconName
    
    return cell!
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    editDelegate.selectIconWithName(iconNameList[indexPath.row])
    self.navigationController?.popViewControllerAnimated(true)
  }
}
