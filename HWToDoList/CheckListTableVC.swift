//
//  ViewController.swift
//  HWToDoList
//
//  Created by Zun Wang on 7/23/15.
//  Copyright (c) 2015 ZW. All rights reserved.
//

import UIKit

protocol AddCheckListDelegate: NSObjectProtocol {
  func addCheckList(newCheckList: CheckList);
}

class MainTableVC: UITableViewController, AddCheckListDelegate {
  
  var checkListList = [CheckList]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Checklists"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "didTapAddButton")
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return checkListList.count;
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = self.tableView.dequeueReusableCellWithIdentifier("MainTableViewCell") as? UITableViewCell
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MainTableViewCell")
    }
    
    if checkListList.count > indexPath.row {
      let checkList = checkListList[indexPath.row]
      let name = checkList.name
      let icon = checkList.icon
      let itemNumber = checkList.itemList.count
      cell!.textLabel?.text = name
      cell!.detailTextLabel?.text = "\(itemNumber) Remaining" // Need to change
      cell!.detailTextLabel?.textColor = UIColor.grayColor()
      cell!.imageView?.image = icon
      cell!.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton
    } else {
      assertionFailure("check list missing!")
    }
    
    return cell!
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section < checkListList.count {
      let checkListItemTableVC = CheckListItemTableVC(checkList: checkListList[indexPath.row])
      self.navigationController?.pushViewController(checkListItemTableVC, animated: true)
    }
  }
  
  // MARK: - AddCheckListDelegate
  
  func addCheckList(newCheckList: CheckList) {
    checkListList.append(newCheckList)
    tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: checkListList.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
  }
  
  // MARK: - Tap Action
  
  func didTapAddButton() {
    let addCheckListVC = AddCheckListVC(addCheckListDelegate: self)
    self.navigationController?.pushViewController(addCheckListVC, animated: true)
  }
  
}

