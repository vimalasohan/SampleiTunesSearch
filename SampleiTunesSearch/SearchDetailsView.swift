//
//  SearchDetailsView.swift
//  SampleiTunesSearch
//
//  Created by vimal asohan on 7/4/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

import Foundation

class SearchDetailsView:UIViewController,UIWebViewDelegate
{
    var detailsData:NSDictionary = [:]
    
    @IBOutlet weak var descriptionImageview: UIImageView!
    
    @IBOutlet weak var detailsTrackName: UILabel!
    
    @IBOutlet weak var descriptionWebview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invokeTrackDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func invokeTrackDetails() {
        self.descriptionWebview.delegate = self
        if (detailsData.objectForKey(RESULT_STRING_TRACK_NAME) != nil) {
            self.detailsTrackName.text = detailsData.objectForKey(RESULT_STRING_TRACK_NAME) as? String
        }else{
            self.detailsTrackName.text = detailsData.objectForKey(RESULT_STRING_COLLECTION_NAME) as? String
        }
        let concurrentQueue : dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(concurrentQueue,{
            if (self.detailsData.objectForKey(RESULT_STRING_IMAGE_URL_100) != nil) {
                let imageURL : NSURL = NSURL(string: self.detailsData.objectForKey(RESULT_STRING_IMAGE_URL_100) as! String)!
                self.descriptionImageview.setImageWithURL(imageURL, placeholderImage: UIImage(named: DEFAULT_IMAGE_LOADING))
            }
        });
        self.invokeWebViewDescription()
    }
    
    func invokeWebViewDescription()
    {
        if (detailsData.objectForKey(RESULT_STRING_LONG_DESCRIPTION) != nil) {
            
            displayContentInWebView(RESULT_STRING_LONG_DESCRIPTION)
        }
        else if (detailsData.objectForKey(RESULT_STRING_DESCRIPTION) != nil) {
            
            displayContentInWebView(RESULT_STRING_DESCRIPTION)
        }
        else if (detailsData.objectForKey(RESULT_STRING_PREVIEW_URL) != nil) {
            
            let videoURL : NSURL = NSURL(string: detailsData.objectForKey(RESULT_STRING_PREVIEW_URL) as! String)!
            self.descriptionWebview.loadRequest(NSURLRequest(URL: videoURL))
        
        }
        else{
            displayContentInWebView(RESULT_STRING_COLLECTIONVIEW_URL)
        }
        
    }
    
    func displayContentInWebView(resultString:NSString) {
        let resultStringValue = detailsData.objectForKey(resultString) as! String
        self.descriptionWebview.loadHTMLString(resultStringValue as String, baseURL: nil)
    }
    
}