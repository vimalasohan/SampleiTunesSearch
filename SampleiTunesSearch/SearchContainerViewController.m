//
//  SearchContainerViewController.m
//  SampleiTunesSearch
//
//  Created by vimal asohan on 6/22/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#import "SearchContainerViewController.h"
#import "SearchConstants.h"
#import "VSDropdown.h"
#define ENTITY_VALUES_DROPDOWN [NSArray arrayWithObjects: @"movie",@"podcast",@"music",@"musicVideo",@"audiobook",@"shortFilm",@"tvShow",@"software",@"ebook",@"all",nil]


@interface SearchContainerViewController ()<VSDropdownDelegate>

@property (nonatomic, retain) NSString *allSelectedItems;
@property (nonatomic, retain) NSDictionary *searchValues;

@end

@implementation SearchContainerViewController

VSDropdown *_dropdown;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_searchBarField setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)entityButtonClicked:(id)sender {
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    [self showDropDownForButton:sender adContents:ENTITY_VALUES_DROPDOWN multipleSelection:NO];
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SEARCHBUTTON_CLICKED_NOTIFICATION object:nil];
}

#pragma mark - SearchBar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _searchBarString= searchBar.text;
    [searchBar resignFirstResponder];
    _searchValues = @{SEARCH_BAR_STRING_VALUE:_searchBarString,
                      ENTITY_VALUE_SELECTED:_allSelectedItems};
    [[NSNotificationCenter defaultCenter]postNotificationName:SEARCHBUTTON_CLICKED_NOTIFICATION object:nil userInfo:_searchValues];
}

#pragma mark - Animated Dropdown Delegate
- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    UIButton *btn = (UIButton *)dropDown.dropDownView;
    [_searchBarField setHidden:NO];
    if (dropDown.selectedItems.count > 1)
    {
        _allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@";"];
        
    }
    else
    {
        _allSelectedItems = [dropDown.selectedItems firstObject];

    }
    [btn setTitle:_allSelectedItems forState:UIControlStateNormal];
    if (_searchBarString!=nil) {
        _searchValues = @{SEARCH_BAR_STRING_VALUE:_searchBarString,
                          ENTITY_VALUE_SELECTED:_allSelectedItems};
        [[NSNotificationCenter defaultCenter]postNotificationName:SEARCHBUTTON_CLICKED_NOTIFICATION object:nil userInfo:_searchValues];
    }

}

-(void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection
{
    
    [_dropdown setDrodownAnimation:rand()%2];
    
    [_dropdown setAllowMultipleSelection:multipleSelection];
    
    [_dropdown setupDropdownForView:sender];
    
    [_dropdown setSeparatorColor:sender.titleLabel.textColor];
    
    if (_dropdown.allowMultipleSelection)
    {
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:[[sender titleForState:UIControlStateNormal] componentsSeparatedByString:@";"]];
        
    }
    else
    {
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:@[[sender titleForState:UIControlStateNormal]]];
        
    }
    
}

- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
    UIButton *btn = (UIButton *)dropdown.dropDownView;
    
    return btn.titleLabel.textColor;
    
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 2.0;
}

- (CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown
{
    return 3.0;
}

- (CGFloat)offsetForDropdown:(VSDropdown *)dropdown
{
    return -2.0;
}

@end
