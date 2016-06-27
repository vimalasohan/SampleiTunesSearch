//
//  ViewController.m
//  SampleiTunesSearch
//
//  Created by vimal asohan on 6/22/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#import "SearchHomeViewController.h"
#import "searchDetailsViewController.h"
#import "searchDynamicTableViewCell.h"
#import "SHActivityView.h"
#import "AFNetworking.h"
#import "SCLAlertView.h"
#import "SearchConstants.h"

@interface SearchHomeViewController ()
@property (nonatomic, retain) NSArray *reponseArray;
-(void)showActivityIndicator;
@end

@implementation SearchHomeViewController
SHActivityView *spinnerSmall;
NSString *entityValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reponseArray = [[NSArray alloc] init];
    _searchTableView.estimatedRowHeight = TABLEVIEW_ESTIMATED_ROW_HEIGHT;
    _searchTableView.rowHeight = UITableViewAutomaticDimension;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchFieldClicked:) name:SEARCHBUTTON_CLICKED_NOTIFICATION object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.reponseArray && self.reponseArray.count) {
        return self.reponseArray.count;
    } else {
        return ZERO_COUNT;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *basicReuseIdentifier = CELL_REUSE_IDENTIFIER;
    SearchDynamicTableViewCell *searchTableViewCell = [tableView dequeueReusableCellWithIdentifier:basicReuseIdentifier forIndexPath:indexPath];
    NSDictionary *responseArrayDictionary = [self.reponseArray objectAtIndex:indexPath.row];
    [searchTableViewCell setCellForSearch:responseArrayDictionary];
    return searchTableViewCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:SEGUE_IDENTIFIER sender:nil];
}

#pragma mark- Search Button clicked

-(void)searchFieldClicked:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    NSString *loadURLString = [NSString stringWithFormat:END_POINT_URL,[userInfo objectForKey:SEARCH_BAR_STRING_VALUE],[userInfo objectForKey:ENTITY_VALUE_SELECTED]];
    NSURL *baseURL = [[NSURL alloc] initWithString:loadURLString];
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [self showActivityIndicator];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:baseURL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        self.reponseArray = [responseObject objectForKey:RESULTS_STRING];
        //NSLog(@"JSON: %@", responseObject);
        if (self.reponseArray.count==ZERO_COUNT) {
            [alert showInfo:self title:INFO_MESSAGE_ALERTVIEW_TITLE subTitle:INFO_MESSAGE_ALERTVIEW_SUBTITLE closeButtonTitle:ALERT_CLOSEBUTTON_TITLE duration:ALERT_VIEW_TIME_DURATION];
        }
        [spinnerSmall dismissAndStopAnimation];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self animateTableCell];
        });    } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         //NSLog(@"Error: %@", error);
         [spinnerSmall dismissAndStopAnimation];
         NSString *getError = error.localizedDescription;
         [alert showError:self title:ERROR_MESSAGE_ALERTVIEW_TITLE
                 subTitle:[NSString stringWithFormat:ERROR_MESSAGE_ALERTVIEW_SUBTITLE,getError]
         closeButtonTitle:ALERT_CLOSEBUTTON_TITLE duration:ALERT_VIEW_TIME_DURATION];
         
     }];
}


#pragma mark- Animated Cell and Custom Activity Indicator

-(void)showActivityIndicator{
    
    spinnerSmall = [[SHActivityView alloc]init];
    spinnerSmall.spinnerSize = kSHSpinnerSizeMedium;
    spinnerSmall.centerTitle = LOADING_INDICATOR_TITLE;
    spinnerSmall.centerTitleColor = UI_LOADING_INDICATOR_COLOR;
    spinnerSmall.spinnerColor = UI_LOADING_INDICATOR_COLOR;
    [self.view addSubview:spinnerSmall];
    [spinnerSmall showAndStartAnimate];
    spinnerSmall.center = SPINNER_CENTER_FRAME;
}

-(void)animateTableCell{
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.fillMode = kCAFillModeForwards;
    transition.duration = TABLEVIEW_ANIMATION_DELAY;
    transition.subtype = kCATransitionFromBottom;
    [[_searchTableView layer] addAnimation:transition forKey:RELOAD_TABLEVIEWCELL_ANIMATION_KEY];
    [_searchTableView reloadData];
}

#pragma mark- Segue to display Track Details

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:SEGUE_IDENTIFIER]) {
        NSDictionary *detailsData = [self.reponseArray objectAtIndex:_searchTableView.indexPathForSelectedRow.row];
        SearchDetailsViewController *detailViewController = [segue destinationViewController];
        detailViewController.detailsData = detailsData;
    }
}

@end
