//
//  SearchConstants.h
//  SampleiTunesSearch
//
//  Created by vimal asohan on 6/25/16.
//  Copyright © 2016 vimal asohan. All rights reserved.
//

#ifndef SearchConstants_h
#define SearchConstants_h

#import<Foundation/Foundation.h>

#define INVOKE_DESCRIPTION(Description_Type)\
{\
[self.descriptionWebview loadHTMLString:[_detailsData objectForKey:Description_Type] baseURL:nil];\
}
#define INVOKE_PRICE(RESPONSE_PRICE)\
{\
[self numberFormatForPrice:[[responseArrayDictionary objectForKey:RESPONSE_PRICE] stringValue]];\
self.priceTrackString.text = [NSString stringWithFormat:DOLLAR_STRING,_responseValueForPrice];\
}
#define UI_LOADING_INDICATOR_COLOR [UIColor colorWithRed:0.09 green:0.71 blue:0.96 alpha:1.0];
#define SPINNER_CENTER_FRAME CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//HomeViewController String Constants

static NSString * const END_POINT_URL = @"http://itunes.apple.com/search?term=%@&country=us&entity=%@";
static NSString * const RESULTS_STRING = @"results";

static NSString * const CELL_REUSE_IDENTIFIER = @"basicCell";

static NSString * const SEGUE_IDENTIFIER = @"showTrackDetails";

static NSString * const LOADING_INDICATOR_TITLE = @"Searching";

static NSString * const RELOAD_TABLEVIEWCELL_ANIMATION_KEY = @"UITableViewReloadDataAnimationKey";

static NSString * const SEARCH_BAR_STRING_VALUE = @"searchBarString";

static NSString * const ENTITY_VALUE_SELECTED = @"entitySelectionString";

//ALERT MESSAGES
static NSString * const ERROR_MESSAGE_ALERTVIEW_TITLE = @"OOPS..";

static NSString * const ERROR_MESSAGE_ALERTVIEW_SUBTITLE = @"We are sorry, Please try again later..%@";

static NSString * const ALERT_CLOSEBUTTON_TITLE = @"OK";

static NSString * const INFO_MESSAGE_ALERTVIEW_TITLE = @"No Results Found";

static NSString * const INFO_MESSAGE_ALERTVIEW_SUBTITLE = @"Please try a different key word/ Try searching a different entity";

static float const ALERT_VIEW_TIME_DURATION = 0.0f;

static float const TABLEVIEW_ANIMATION_DELAY = 0.8f;

static float const TABLEVIEW_ESTIMATED_ROW_HEIGHT = 300.0f;

static int const ZERO_COUNT = 0;

//NOTIFICATION MESSAGES

static NSString * const SEARCHBUTTON_CLICKED_NOTIFICATION = @"searchClickedinContainer";

static NSString * const ENTITYBUTTON_CLICKED_NOTIFICATION = @"searchEntitySelected";


//SearchDetailsViewController String Constants
static NSString * const DEFAULT_IMAGE_LOADING = @"ImageView_Default.png";
//Response Object Values
static NSString * const RESULT_STRING_TRACK_NAME = @"trackName";

static NSString * const RESULT_STRING_COLLECTION_NAME = @"collectionName";

static NSString * const RESULT_STRING_IMAGE_URL_100 = @"artworkUrl100";

static NSString * const RESULT_STRING_LONG_DESCRIPTION = @"longDescription";

static NSString * const RESULT_STRING_DESCRIPTION = @"description";

static NSString * const RESULT_STRING_PREVIEW_URL = @"previewUrl";

static NSString * const RESULT_STRING_COLLECTIONVIEW_URL = @"collectionViewUrl";


//SearchContainerView String Constants

static NSString * const RESULT_STRING_SHORT_DESCRIPTION = @"artistName";

static NSString * const RESULT_STRING_TRACK_PRICE = @"trackPrice";

static NSString * const RESULT_STRING_COLLECTION_PRICE = @"collectionPrice";

static NSString * const RESULT_STRING_PRICE = @"price";

//SearchDyanmicTableViewCell String Constants

static NSString * const RESULT_STRING_IMAGE_URL_60 = @"artworkUrl60";

static NSString * const RESULT_STRING_DEFAULT_PRICE = @"0.00";

static NSString * const DOLLAR_STRING = @"$%@";

#endif /* SearchConstants_h */
