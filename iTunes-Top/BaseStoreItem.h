//
//  BaseStoreItem.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseStoreItem : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *contentType;
@property (strong, nonatomic) NSString *categoryType;
@property (strong, nonatomic) NSString *iTunesLink;

@end
