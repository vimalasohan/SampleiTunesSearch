//
//  searchDetailsViewController.h
//  SampleiTunesSearch
//
//  Created by vimal asohan on 6/24/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDetailsViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *descriptionWebview;
@property (weak, nonatomic) IBOutlet UILabel *detailsTrackName;
@property (weak, nonatomic) IBOutlet UIImageView *detailsImageView;
@property (weak,nonatomic) NSDictionary *detailsData;
@end
