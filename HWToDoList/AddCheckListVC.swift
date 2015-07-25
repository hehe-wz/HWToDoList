//
//  AddCheckListVC.swift
//  HWToDoList
//
//  Created by Zun Wang on 7/23/15.
//  Copyright (c) 2015 ZW. All rights reserved.
//

import UIKit

protocol EditCheckListIconDelegate: NSObjectProtocol {
  func selectIconWithName(name: String);
}

class AddCheckListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, EditCheckListIconDelegate {
  var icon = UIImage(named: "No Icon")
  let nameTextField = UITextField()
  let addCheckListDelegate: AddCheckListDelegate
  weak var tableView: UITableView!
  
  init(addCheckListDelegate: AddCheckListDelegate) {
    self.addCheckListDelegate = addCheckListDelegate
    super.init(nibName: nil, bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
//  required init!(coder aDecoder: NSCoder!) {
//    fatalError("init(coder:) has not been implemented")
//  }
  
  override func loadView() {
    self.view = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
    tableView = self.view as! UITableView
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
    
    self.title = "Add Checklist"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "didTapCancelButton")
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "didTapDoneButton")
  }
  
  // MARK: - UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell : UITableViewCell
    
    if indexPath.section == 0 {
      cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "AddCheckListTableViewSection0Cell")
      
      var frame = cell.bounds
      frame.size.width -= 30
      frame.origin.x += 15
      nameTextField.frame = frame
      nameTextField.placeholder = "Name of the List"
      
      cell.contentView.addSubview(nameTextField)
    } else {
      cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "AddCheckListTableViewSection1Cell")
      cell.textLabel?.text = "Icon"
      cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
      
      let iconView = UIImageView(image: icon)
      let originX = CGRectGetWidth(cell.contentView.frame) - CGRectGetWidth(iconView.bounds) - 50
      let originY = (CGRectGetHeight(cell.contentView.frame) - CGRectGetHeight(iconView.bounds)) / 2
      let frame = CGRect(origin: CGPoint(x: originX, y:originY), size: iconView.bounds.size)
      iconView.frame = frame
      cell.contentView.addSubview(iconView)
    }
    
    return cell;
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 1 {
      let iconListTableVC = IconListTableVC(editDelegate: self)
      self.navigationController?.pushViewController(iconListTableVC, animated: true)
    }
  }
  
  func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    if indexPath.section == 0 {
      return false
    }
    
    return true
  }
  
  // MARK: - EditCheckListIconDelegate
  
  func selectIconWithName(name: String) {
    icon = UIImage(named: name)
    tableView.reloadData()
  }
  
  // MARK: - User Action
  
  func didTapCancelButton() {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  func didTapDoneButton() {
    let newCheckList = CheckList(name: nameTextField.text, icon: icon!)
    addCheckListDelegate.addCheckList(newCheckList)
    
    self.navigationController?.popViewControllerAnimated(true)
  }
}
