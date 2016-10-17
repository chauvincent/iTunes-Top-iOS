//
//  Constants.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "Constants.h"

@implementation Constants

#pragma mark - NSNotification Observer Constants

NSString *const kObserverFinishedAll            = @"FinishedAll";
NSString *const kObserverFinishedSongs          = @"FinishedSongs";
NSString *const kObserverFinishedAudioBook      = @"FinishedAudioBooks";
NSString *const kObserverFinishedCollection     = @"FinishedCollection";

#pragma mark - Data Endpoint Constants

NSString *const kEndpointSongs                  = @"https://itunes.apple.com/us/rss/topsongs/limit=100/json";
NSString *const kEndpointAudioBook              = @"https://itunes.apple.com/us/rss/topaudiobooks/limit=100/json";
NSString *const kEndpointCollection             = @"https://itunes.apple.com/us/rss/topitunesucollections/limit=100/json";

@end
