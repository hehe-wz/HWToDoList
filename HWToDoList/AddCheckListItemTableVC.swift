//
//  AddCheckListItemTableVC.swift
//  HWToDoList
//
//  Created by Zun Wang on 7/24/15.
//  Copyright (c) 2015 ZW. All rights reserved.
//

import UIKit

class AddCheckListItemTableVC: UITableViewController {
  
  let nameTextField = UITextField()
  var dueDate = NSDate()
  let remindSwitch = UISwitch()
//  let addCheckListDelegate: AddCheckListDelegate
  
//  init(addCheckListDelegate: AddCheckListDelegate) {
//    self.addCheckListDelegate = addCheckListDelegate
//    super.init(nibName: nil, bundle: nil)
//  }
//  
//  required init!(coder aDecoder: NSCoder!) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
    
    self.title = "Add Item"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "didTapCancelButton")
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "didTapDoneButton")
  }
  
  // MARK: - UITableViewDataSource
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    default:
      return 2
    }
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell : UITableViewCell
    
    if indexPath.section == 0 {
      cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "AddCheckListTableViewSection0Cell")
      
      var frame = cell.bounds
      frame.size.width -= 30
      frame.origin.x += 15
      nameTextField.frame = frame
      nameTextField.placeholder = "Name of the Item"
      
      cell.contentView.addSubview(nameTextField)
    } else {
      if indexPath.row == 0 {
        cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "AddCheckListTableViewSection1Cell")
        cell.textLabel?.text = "Remind Me"
        cell.accessoryView = remindSwitch
      } else {
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "AddCheckListTableViewSection1Cell")
        cell.textLabel?.text = "Icon"
//        
//        let iconView = UIImageView(image: icon)
//        let originX = CGRectGetWidth(cell.contentView.frame) - CGRectGetWidth(iconView.bounds) - 50
//        let originY = (CGRectGetHeight(cell.contentView.frame) - CGRectGetHeight(iconView.bounds)) / 2
//        let frame = CGRect(origin: CGPoint(x: originX, y:originY), size: iconView.bounds.size)
//        iconView.frame = frame
//        cell.contentView.addSubview(iconView)
      }
    }
    
    return cell;
  }
  
  // MARK: - UITableViewDelegate
  
//  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//    if indexPath.section == 1 {
//      let iconListTableVC = IconListTableVC(editDelegate: self)
//      self.navigationController?.pushViewController(iconListTableVC, animated: true)
//    }
//  }
//  
//  override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    if indexPath.section == 0 {
//      return false
//    }
//    
//    return true
//  }
//  
//  // MARK: - EditCheckListIconDelegate
//  
//  func selectIconWithName(name: String) {
//    icon = UIImage(named: name)
//    self.tableView.reloadData()
//  }
//  
//  // MARK: - User Action
//  
//  func didTapCancelButton() {
//    self.navigationController?.popViewControllerAnimated(true)
//  }
//  
//  func didTapDoneButton() {
//    let newCheckList = CheckList(name: nameTextField.text, icon: icon!)
//    addCheckListDelegate.addCheckList(newCheckList)
//    
//    self.navigationController?.popViewControllerAnimated(true)
//  }
  
}
