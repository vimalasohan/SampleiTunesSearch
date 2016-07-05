//
//  SearchContainerView.swift
//  SampleiTunesSearch
//
//  Created by vimal asohan on 7/4/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

import Foundation


class SearchContainerView : UIViewController,UISearchBarDelegate,VSDropdownDelegate
{
    @IBOutlet weak var searchBarField: UISearchBar!
    var searchBarString = ""
    var entitySelectedString = ""
    var searchValues:NSDictionary = [:]
    var dropDownField:VSDropdown = VSDropdown()    
    
    @IBAction func selectEntityClicked(sender: AnyObject) {
        
        dropDownField = VSDropdown.init(delegate: self)
        dropDownField.adoptParentTheme = true;
        dropDownField.shouldSortItems = true;
        self.showDropDownForButton(sender as! UIButton, adContents:SwiftConstants.entityArrayList, multipleSelection: false)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarField.delegate = self
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: SEARCHBUTTON_CLICKED_NOTIFICATION, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBarString = searchBar.text!
        searchBar.resignFirstResponder()
        searchValues = [SEARCH_BAR_STRING_VALUE:searchBarString,ENTITY_VALUE_SELECTED:entitySelectedString]
        NSNotificationCenter.defaultCenter().postNotificationName(SEARCHBUTTON_CLICKED_NOTIFICATION, object: nil, userInfo: searchValues as [NSObject : AnyObject])
    }
    
    func dropdown(dropDown: VSDropdown!, didChangeSelectionForValue str: String!, atIndex index: UInt, selected: Bool) {
        var btn = UIButton()
        btn = dropDown.dropDownView as! UIButton
        searchBarField.hidden = false;
        
        if dropDown.selectedItems.count > 1 {
            entitySelectedString = (dropDown.selectedItems as NSArray).componentsJoinedByString(";")
        }
        else
        {
            entitySelectedString = (dropDown.selectedItems as NSArray).firstObject as! String
        }
        btn.setTitle(entitySelectedString, forState: .Normal)
    }
    
    func showDropDownForButton(sender:UIButton,adContents:NSArray,multipleSelection:Bool) {
        
        dropDownField.drodownAnimation = DropdownAnimation.None
        dropDownField.allowMultipleSelection = multipleSelection
        dropDownField.separatorColor = sender.titleLabel?.textColor
        dropDownField.setupDropdownForView(sender)
        guard dropDownField.allowMultipleSelection else{
            dropDownField.reloadDropdownWithContents(adContents as [AnyObject], andSelectedItems: (sender .titleForState(UIControlState.Normal)!.componentsSeparatedByString(" ")))
            
            return
        }
        dropDownField.reloadDropdownWithContents(adContents as [AnyObject], andSelectedItems: (sender .titleForState(UIControlState.Normal)!.componentsSeparatedByString(";")))
    }
    
    func outlineColorForDropdown(dropdown: VSDropdown!) -> UIColor! {
        
        var btn = UIButton()
        btn = dropdown.dropDownView as! UIButton
        return btn.titleLabel?.textColor;
        
    }
    
    func outlineWidthForDropdown(dropdown: VSDropdown!) -> CGFloat {
        return 2.0
    }
    
    func cornerRadiusForDropdown(dropdown: VSDropdown!) -> CGFloat {
        return 3.0
    }
    
    func offsetForDropdown(dropdown: VSDropdown!) -> CGFloat {
        return -2.0
    }
}