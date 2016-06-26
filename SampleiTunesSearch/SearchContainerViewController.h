//
//  SearchContainerViewController.h
//  SampleiTunesSearch
//
//  Created by vimal asohan on 6/22/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchContainerViewController : UIViewController<UISearchBarDelegate>{
}
@property (nonatomic, retain) NSString *searchBarString;
@property(nonatomic,strong) IBOutlet UIButton *selectEntityButton;
@property(nonatomic,strong) IBOutlet UISearchBar *searchBarField;
@end


