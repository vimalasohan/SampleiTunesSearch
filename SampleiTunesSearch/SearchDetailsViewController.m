//
//  searchDetailsViewController.m
//  SampleiTunesSearch
//
//  Created by vimal asohan on 6/24/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#import "searchDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SearchConstants.h"

@interface SearchDetailsViewController ()

@end

@implementation SearchDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self invokeTrackDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Fetch TrackDetails and Description
-(void) invokeTrackDetails
{
    self.descriptionWebview.delegate = self;
    if([_detailsData objectForKey:RESULT_STRING_TRACK_NAME]!=nil)
        self.detailsTrackName.text = [_detailsData objectForKey:RESULT_STRING_TRACK_NAME];
    else{
        self.detailsTrackName.text = [_detailsData objectForKey:RESULT_STRING_COLLECTION_NAME];
    }
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        if ([_detailsData objectForKey:RESULT_STRING_IMAGE_URL_100]!=nil) {
            NSURL *imageURL = [[NSURL alloc] initWithString:[_detailsData objectForKey:RESULT_STRING_IMAGE_URL_100]];
            [self.detailsImageView setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:DEFAULT_IMAGE_LOADING]];
        }
    });
    [self invokeWebViewDescription];
}

- (void)invokeWebViewDescription
{
    if ([_detailsData objectForKey:RESULT_STRING_LONG_DESCRIPTION]!=nil) {
        INVOKE_DESCRIPTION(RESULT_STRING_LONG_DESCRIPTION)
    }
    else if ([_detailsData objectForKey:RESULT_STRING_DESCRIPTION]!=nil){
        INVOKE_DESCRIPTION(RESULT_STRING_DESCRIPTION)
    }
    else if ([_detailsData objectForKey:RESULT_STRING_PREVIEW_URL]!=nil)
    {
        NSURL *previewURL = [[NSURL alloc] initWithString:[_detailsData objectForKey:RESULT_STRING_PREVIEW_URL]];
        [self.descriptionWebview loadRequest:[NSURLRequest requestWithURL:previewURL]];

    }
    else
    {
        INVOKE_DESCRIPTION(RESULT_STRING_COLLECTIONVIEW_URL)
    }
}

@end
