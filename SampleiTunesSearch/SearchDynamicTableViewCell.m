//
//  searchDynamicTableViewCell.m
//  SampleiTunesSearch
//
//  Created by vimal asohan on 6/23/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#import "SearchDynamicTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "SearchConstants.h"

@interface SearchDynamicTableViewCell ()

@property (weak, nonatomic) NSString *responseValueForPrice;

@end

@implementation SearchDynamicTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    [self resetCellValues];
}

#pragma mark- Cell implementation and Reset

-(void)setCellForSearch:(NSDictionary *)responseArrayDictionary
{
    if([responseArrayDictionary objectForKey:RESULT_STRING_TRACK_NAME]!=nil){
        self.trackNameString.text = [responseArrayDictionary objectForKey:RESULT_STRING_TRACK_NAME];
    }
    else{
        self.trackNameString.text = [responseArrayDictionary objectForKey:RESULT_STRING_COLLECTION_NAME];
    }
    self.shortDescriptionString.text = [responseArrayDictionary objectForKey: RESULT_STRING_SHORT_DESCRIPTION];
    if ([[responseArrayDictionary objectForKey:RESULT_STRING_TRACK_PRICE] stringValue]!=nil) {
        INVOKE_PRICE(RESULT_STRING_TRACK_PRICE)
    }
    else if ([[responseArrayDictionary objectForKey:RESULT_STRING_COLLECTION_PRICE] stringValue]!=nil){
        INVOKE_PRICE(RESULT_STRING_COLLECTION_PRICE)
    }
    else if ([[responseArrayDictionary objectForKey:RESULT_STRING_PRICE] stringValue]!=nil){
        INVOKE_PRICE(RESULT_STRING_PRICE)
    }
    else{
        self.priceTrackString.text = [NSString stringWithFormat:DOLLAR_STRING,RESULT_STRING_DEFAULT_PRICE];
    }
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        if ([self basicCellImageView]!=nil) {

        NSURL *imageURL = [[NSURL alloc] initWithString:[responseArrayDictionary objectForKey:RESULT_STRING_IMAGE_URL_60]];
        [self.basicCellImageView setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_LOADING]];
        }
    });
    
    [self layoutIfNeeded];
}

-(void)resetCellValues{
    self.trackNameString.text = nil;
    self.shortDescriptionString.text = nil;
    self.priceTrackString.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark- Format Price

-(NSString*)numberFormatForPrice:(NSString*)responseValue
{
    NSNumberFormatter *format = [[NSNumberFormatter alloc]init];
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    [format setRoundingMode:NSNumberFormatterRoundHalfUp];
    [format setMaximumFractionDigits:2];
    [format setMinimumFractionDigits:2];
    self.responseValueForPrice = [format stringFromNumber:@([responseValue doubleValue])];
    return _responseValueForPrice;
}

@end
