//
//  AddCheckListItemTableVC.swift
//  HWToDoList
//
//  Created by Zun Wang on 7/24/15.
//  Copyright (c) 2015 ZW. All rights reserved.
//

import UIKit

class AddCheckListItemTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  let nameTextField = UITextField()
  var dueDate = NSDate()
  let remindSwitch = UISwitch()
  let addCheckListItemDelegate: AddCheckListItemDelegate
  weak var tableView: UITableView!
  let datePicker = UIDatePicker()
  
  init(addCheckListItemDelegate: AddCheckListItemDelegate) {
    self.addCheckListItemDelegate = addCheckListItemDelegate
    super.init(nibName: nil, bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    self.view = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
    tableView = self.view as! UITableView
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Add Item"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "didTapCancelButton")
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "didTapDoneButton")
    datePicker.hidden = true
    self.tableView.addSubview(datePicker)
    self.setupNameTextField()
  }
  
  // MARK: - UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    default:
      return 2
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
        cell.textLabel?.text = "Due Date"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy, HH:mm";
        cell.detailTextLabel!.text = dateFormatter.stringFromDate(dueDate)
      }
    }
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    
    return cell;
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section != 0 {
      self.nameTextField.resignFirstResponder()
    }
    
    if indexPath.section == 1 && indexPath.row == 1 {
      if datePicker.hidden {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        var datePickerFrame = cell!.convertRect(cell!.bounds, toView: self.tableView)
        datePickerFrame.origin.y += datePickerFrame.height
        datePickerFrame.size.height = 200
        datePicker.frame = datePickerFrame
        datePicker.date = dueDate
        datePicker.hidden = false
      } else {
        self.dismissDatePicker()
      }
    }
  }
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 1 && indexPath.row == 1 {
      self.dismissDatePicker()
    }
  }
  
  // MARK: - UITextFieldDelegate and related
  
  func didTapKeyboardDoneButton() {
    nameTextField.resignFirstResponder()
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    self.dismissDatePicker()
  }
  
//  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//    self.dismissDatePicker()
//    return true
//  }
  
  // MARK: - User Action
  
  func didTapCancelButton() {
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  func didTapDoneButton() {
    self.dismissDatePicker() // Save the date picker before pop
    let newCheckListItem = ListItem(name: nameTextField.text, dueDate: dueDate, needRemind: remindSwitch.on)
    addCheckListItemDelegate.addCheckListItem(newCheckListItem)
    
    self.navigationController?.popViewControllerAnimated(true)
  }
  
  // MARK: - Private Method
  
  func dismissDatePicker() {
    if !datePicker.hidden {
      datePicker.hidden = true
      dueDate = datePicker.date
      self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 1)], withRowAnimation: UITableViewRowAnimation.None)
    }
  }
  
  func setupNameTextField() {
    nameTextField.returnKeyType = UIReturnKeyType.Done
    nameTextField.addTarget(self, action: "didTapKeyboardDoneButton", forControlEvents: UIControlEvents.EditingDidEndOnExit)
    nameTextField.delegate = self
  }
}
