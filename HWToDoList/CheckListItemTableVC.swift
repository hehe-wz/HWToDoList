//
//  CheckListItemTableVC.swift
//  HWToDoList
//
//  Created by Zun Wang on 7/24/15.
//  Copyright (c) 2015 ZW. All rights reserved.
//

import UIKit

protocol AddCheckListItemDelegate: NSObjectProtocol {
  func addCheckListItem(newCheckList: ListItem);
}

class CheckListItemTableVC: UITableViewController, AddCheckListItemDelegate {
  
  let checkList : CheckList
  static let checkImage = UIImage(named: "CheckMark")
  
  init(checkList: CheckList) {
    self.checkList = checkList
    super.init(nibName: nil, bundle: nil)
  }
  
  required init!(coder aDecoder: NSCoder!) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = checkList.name
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "didTapAddButton")
  }
  
  // MARK: - UITableViewDataSource
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return checkList.itemList.count;
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = self.tableView.dequeueReusableCellWithIdentifier("CheckListItemTableViewCell") as? UITableViewCell
    if cell == nil {
      cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CheckListItemTableViewCell")
    }
    
    let itemList = checkList.itemList
    
    if itemList.count > indexPath.row {
      let item = itemList[indexPath.row]
      let name = item.name
      cell!.textLabel?.text = name
      cell!.imageView?.image = item.dueDate.compare(NSDate()) == NSComparisonResult.OrderedAscending
        ? CheckListItemTableVC.checkImage
        : nil
      cell!.accessoryType = UITableViewCellAccessoryType.DetailDisclosureButton
    } else {
      assertionFailure("check list missing!")
    }
    
    return cell!
  }
  
  // MARK: - Tap Action
  
  func didTapAddButton() {
    let addCheckListItemVC = AddCheckListItemTableVC(addCheckListItemDelegate: self)
    self.navigationController?.pushViewController(addCheckListItemVC, animated: true)
  }
  
  // MARK: - AddCheckListItemDelegate
  
  func addCheckListItem(newCheckList: ListItem) {
    checkList.itemList.append(newCheckList)
    self.tableView.reloadData()
  }
}
