//
//  SampleiTunesSearchTests.m
//  SampleiTunesSearchTests
//
//  Created by vimal asohan on 6/22/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SearchHomeViewController.h"
#import "SearchContainerViewController.h"
#import "SearchDetailsViewController.h"
#import "SearchDynamicTableViewCell.h"
#import "SearchConstants.h"

@interface SampleiTunesSearchTests : XCTestCase

@end

@implementation SampleiTunesSearchTests
{
    SearchHomeViewController *homeViewController;
    SearchDetailsViewController *detailsViewController;
    SearchContainerViewController *containerViewController;
    SearchDynamicTableViewCell *dynamicTableCell;
}
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    homeViewController = [storyboard instantiateViewControllerWithIdentifier:
                          @"SearchHomeViewController"];
    containerViewController = [storyboard instantiateViewControllerWithIdentifier:
                               @"SearchContainerViewController"];
    detailsViewController = [storyboard instantiateViewControllerWithIdentifier:
                             @"SearchDetailsViewController"];
    [homeViewController view];
    [containerViewController view];
    [detailsViewController view];
    dynamicTableCell = [[SearchDynamicTableViewCell alloc]init];
}

#pragma mark- Testing ViewController Exists

-(void)testViewControllersExists {
    XCTAssertNotNil([homeViewController view], @"HomeViewController should contain a view");
    XCTAssertNotNil([detailsViewController view], @"DetailsViewController should contain a view");
    XCTAssertNotNil([containerViewController view], @"ContainerViewController should contain a view");
}

#pragma mark- Testing UIElements

-(void)testUIElementsConnected {
    XCTAssertNotNil([homeViewController searchTableView], @"TableView for SearchProject should be connected");
    XCTAssertNotNil([containerViewController selectEntityButton], @"Entity Button should be connected");
    XCTAssertNotNil([containerViewController searchBarField], @"SearchBar should be connected");
    XCTAssertNotNil([detailsViewController descriptionWebview], @"Webview should be connected");
    XCTAssertNotNil([detailsViewController detailsTrackName], @"Trackname string should be connected");
    XCTAssertNotNil([detailsViewController detailsImageView], @"ImageView should be connected");
}

#pragma mark - UITableView tests

- (void)testTableViewCellExists {
    XCTAssertNotNil(dynamicTableCell, @"TableViewCell class exists");
}

- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([homeViewController conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource
{
    XCTAssertNotNil(homeViewController.searchTableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([homeViewController conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(homeViewController.searchTableView.delegate, @"Table delegate cannot be nil");
}

- (void)testTableViewNumberOfRowsInSection
{
    NSInteger expectedRows = 0;
    XCTAssertTrue([homeViewController tableView:homeViewController.searchTableView numberOfRowsInSection:0]==expectedRows, @"Table has %ld rows but it should have %ld", (long)[homeViewController tableView:homeViewController.searchTableView numberOfRowsInSection:0], (long)expectedRows);
}

#pragma mark- Entity Button Action Tests

-(void)testEntityButtonCheckIBAction {
    NSArray *actions = [containerViewController.selectEntityButton actionsForTarget:containerViewController
                                                                    forControlEvent:UIControlEventTouchUpInside];
    XCTAssertTrue([actions containsObject:@"entityButtonClicked:"], @"");
}

#pragma mark- SearchBar tests
-(void)testShould_Set_SearchBarDelegate {
    XCTAssertNotNil(containerViewController.searchBarField.delegate);
}

-(void)testValidSearchBarDelegateProtocol {
    [containerViewController searchBarSearchButtonClicked:containerViewController.searchBarField];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    homeViewController = nil;
    containerViewController = nil;
    detailsViewController = nil;
    dynamicTableCell = nil;
    [super tearDown];
}

-(void)testNotificationAndServiceTriggered{
    
    NSNotification *notification=[[NSNotification alloc] initWithName:SEARCHBUTTON_CLICKED_NOTIFICATION object:nil userInfo:@{SEARCH_BAR_STRING_VALUE:@"Harry", ENTITY_VALUE_SELECTED:@"Movie"}];
    [homeViewController searchFieldClicked:notification andCompletion:^{
        XCTAssertTrue(homeViewController.reponseArray.count>0);

    }];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
