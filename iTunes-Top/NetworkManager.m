//
//  NetworkManager.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (NetworkManager *)sharedInstance
{
    static NetworkManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NetworkManager alloc] init];
    });
    
    return _sharedInstance;
}


@end
