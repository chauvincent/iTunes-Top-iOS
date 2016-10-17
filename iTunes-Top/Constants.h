//
//  Constants.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#pragma mark - NSNotification Observer Constants

extern NSString *const kObserverFinishedAll;
extern NSString *const kObserverFinishedSongs;
extern NSString *const kObserverFinishedAudioBook;
extern NSString *const kObserverFinishedCollection;

#pragma mark - Data Endpoint Constants

extern NSString *const kEndpointSongs;
extern NSString *const kEndpointAudioBook;
extern NSString *const kEndpointCollection;


@end
