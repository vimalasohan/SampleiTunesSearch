//
//  SearchHomeViewController.h
//  SampleiTunesSearch
//
//  Created by vimal asohan on 6/22/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) NSArray *reponseArray;
@property(nonatomic, strong)IBOutlet UITableView *searchTableView;
-(void)searchFieldClicked:(NSNotification *)notification;
-(void)searchFieldClicked:(NSNotification *)notification andCompletion:(void(^)(void))completion;
@end
