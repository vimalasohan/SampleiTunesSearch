//
//  searchDynamicTableViewCell.h
//  SampleiTunesSearch
//
//  Created by vimal asohan on 6/23/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchDynamicTableViewCell : UITableViewCell

-(void)setCellForSearch:(NSDictionary *)movie;
@property (weak, nonatomic) IBOutlet UIImageView *basicCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *trackNameString;
@property (weak, nonatomic) IBOutlet UILabel *shortDescriptionString;
@property (weak, nonatomic) IBOutlet UILabel *priceTrackString;

@end
