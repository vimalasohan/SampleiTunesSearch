//
//  SearchDynamicTableCell.swift
//  SampleiTunesSearch
//
//  Created by vimal asohan on 7/4/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

import Foundation


class SearchDynamicTableCell : UITableViewCell
{
    @IBOutlet weak var basicCellImageView: UIImageView!
    @IBOutlet weak var trackNameString: UILabel!
    @IBOutlet weak var shortDescriptionString: UILabel!
    @IBOutlet weak var priceTrackString: UILabel!
    var responseValueForPrice  = ""
    
    func setCellForSearch(responseArrayDictionary:NSDictionary)  {
      
        if (responseArrayDictionary.objectForKey(RESULT_STRING_TRACK_NAME) != nil)
        {
            self.trackNameString.text = responseArrayDictionary.objectForKey(RESULT_STRING_TRACK_NAME) as? String
            
        }
        else{
        self.trackNameString.text = responseArrayDictionary.objectForKey(RESULT_STRING_COLLECTION_NAME) as? String
        }
        self.shortDescriptionString.text = responseArrayDictionary.objectForKey (RESULT_STRING_SHORT_DESCRIPTION) as? String
        if (responseArrayDictionary.objectForKey(RESULT_STRING_TRACK_PRICE) != nil) {
            self.numberFormatForPrice(responseArrayDictionary.objectForKey(RESULT_STRING_TRACK_PRICE)! as! NSNumber)
            self.priceTrackString.text = NSString(format: DOLLAR_STRING,responseValueForPrice) as String
        }
        else if(responseArrayDictionary.objectForKey(RESULT_STRING_COLLECTION_PRICE) != nil)
        {
             self.numberFormatForPrice(responseArrayDictionary.objectForKey(RESULT_STRING_COLLECTION_PRICE)! as! NSNumber)
            self.priceTrackString.text = NSString(format: DOLLAR_STRING,responseValueForPrice) as String
        }
        else if(responseArrayDictionary.objectForKey(RESULT_STRING_PRICE) != nil)
        {
             self.numberFormatForPrice(responseArrayDictionary.objectForKey(RESULT_STRING_PRICE)! as! NSNumber)
            self.priceTrackString.text = NSString(format: DOLLAR_STRING,responseValueForPrice) as String
        }
        else{
            self.priceTrackString.text = NSString(format: DOLLAR_STRING,RESULT_STRING_DEFAULT_PRICE) as String
        }
        let concurrentQueue : dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(concurrentQueue,{
            if (responseArrayDictionary.objectForKey(RESULT_STRING_IMAGE_URL_60) != nil) {
                let imageURL : NSURL = NSURL(string: responseArrayDictionary.objectForKey(RESULT_STRING_IMAGE_URL_60) as! String)!
                self.basicCellImageView.setImageWithURL(imageURL, placeholderImage: UIImage(named: DEFAULT_IMAGE_LOADING))
           }
        });
        self.layoutIfNeeded()
    }
    
    func numberFormatForPrice(responsePriceString:NSNumber) -> NSString {
    
        let format : NSNumberFormatter = NSNumberFormatter()
        format.numberStyle = .DecimalStyle
        format.roundingMode = .RoundHalfUp
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        self.responseValueForPrice = format.stringFromNumber(responsePriceString.doubleValue)!
        return responseValueForPrice
    }

}