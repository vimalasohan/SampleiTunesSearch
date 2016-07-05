//
//  SearchHomeViewControl.swift
//  SampleiTunesSearch
//
//  Created by vimal asohan on 7/4/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

import Foundation

class SearchHomeViewControl: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var searchTableView: UITableView!
    var responseArray:NSArray = []
    var spinnerSmall : SHActivityView = SHActivityView.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTableView.estimatedRowHeight = CGFloat(TABLEVIEW_ESTIMATED_ROW_HEIGHT);
        self.searchTableView.rowHeight = UITableViewAutomaticDimension
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchHomeViewControl.searchFieldClicked(_:)), name: SEARCHBUTTON_CLICKED_NOTIFICATION, object: nil)
        
    }
    
    func searchFieldClicked(notificationObject:NSNotification)  {
        var userInfo:NSDictionary = [:]
        userInfo = notificationObject.userInfo!
        let loadURLString =  NSString(format: END_POINT_URL,userInfo.objectForKey(SEARCH_BAR_STRING_VALUE) as! String,userInfo.objectForKey(ENTITY_VALUE_SELECTED) as! String)
        let baseURL = NSURL.init(string: loadURLString as String)
        let alertView:SCLAlertView = SCLAlertView.init()
        self.showActivityIndicator()
        let manager = AFHTTPSessionManager()
        manager.GET((baseURL?.absoluteString)!, parameters: nil, progress: nil, success: {
            (task, responseObject) in
            self.responseArray = (responseObject?.objectForKey(RESULTS_STRING))! as! NSArray
            guard self.responseArray.count>0 else {
               alertView.showInfo(self, title: INFO_MESSAGE_ALERTVIEW_TITLE, subTitle: INFO_MESSAGE_ALERTVIEW_SUBTITLE, closeButtonTitle: ALERT_CLOSEBUTTON_TITLE, duration: SwiftConstants.ALERT_VIEW_TIME_DURATION)
                self.spinnerSmall.dismissAndStopAnimation()
                return
            }
            self.spinnerSmall.dismissAndStopAnimation()
            print(self.responseArray)
            dispatch_async(dispatch_get_main_queue()) {
                self.animateTableCell()
            }
            }, failure: {
                (task, error: NSError!) in
                let getError = error.localizedDescription
                self.spinnerSmall.dismissAndStopAnimation()
                alertView.showError(self, title: ERROR_MESSAGE_ALERTVIEW_TITLE, subTitle: NSString(format: ERROR_MESSAGE_ALERTVIEW_SUBTITLE,getError) as String, closeButtonTitle: ALERT_CLOSEBUTTON_TITLE, duration: SwiftConstants.ALERT_VIEW_TIME_DURATION)
        })
    }
    
    func showActivityIndicator() {
        spinnerSmall.spinnerSize = kSHSpinnerSizeMedium
        spinnerSmall.centerTitle = LOADING_INDICATOR_TITLE
        spinnerSmall.centerTitleColor = SwiftConstants.UI_LOADING_INDICATOR_COLOR
        spinnerSmall.spinnerColor = SwiftConstants.UI_LOADING_INDICATOR_COLOR;
        self.view.addSubview(spinnerSmall)
        spinnerSmall.showAndStartAnimate()
        spinnerSmall.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
    }
    
    func animateTableCell(){
    
        let transition:CATransition = CATransition()
        transition.type = kCATransitionPush
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        transition.fillMode = kCAFillModeForwards
        transition.duration = SwiftConstants.TABLEVIEW_ANIMATION_DELAY
        transition.subtype = kCATransitionFromBottom
        searchTableView.layer .addAnimation(transition, forKey: RELOAD_TABLEVIEWCELL_ANIMATION_KEY)
        searchTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard (self.responseArray.count)<1 else
        {
            return self.responseArray.count
        }
        return SwiftConstants.ZERO_COUNT
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let basicReuseIdentifier = CELL_REUSE_IDENTIFIER;
        let searchTableViewCell:SearchDynamicTableCell = tableView.dequeueReusableCellWithIdentifier(basicReuseIdentifier, forIndexPath: indexPath) as! SearchDynamicTableCell
        let responseArrayDictionary:NSDictionary = self.responseArray.objectAtIndex(indexPath.row) as! NSDictionary
        searchTableViewCell.setCellForSearch(responseArrayDictionary)
        return searchTableViewCell
    }
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == SwiftConstants.SEGUE_IDENTIFIER)
        {
            let detailsData:NSDictionary = self.responseArray .objectAtIndex((searchTableView.indexPathForSelectedRow?.row)!) as! NSDictionary
            let detailsView:SearchDetailsView = segue.destinationViewController as! SearchDetailsView
            detailsView.detailsData = detailsData
        }
    }
    
}