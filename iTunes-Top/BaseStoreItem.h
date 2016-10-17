//
//  BaseStoreItem.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseStoreItem : NSObject
{
    NSString *name;
    NSString *author;
    NSString *price;
    NSString *contentType;
    NSString *categoryType;
    NSString *iTunesLink;
}

@property (readonly) NSString *name;
@property (readonly) NSString *author;
@property (readonly) NSString *price;
@property (readonly) NSString *contentType;
@property (readonly) NSString *categoryType;
@property (readonly) NSString *iTunesLink;


- (instancetype)initWithName:(NSString *)itemName
                   andAuthor:(NSString *)itemAuthor
                   withPrice:(NSString *)itemPrice
                  andContent:(NSString *)itemContentType
                  inCategory:(NSString *)itemCategoryType
                   andItunes:(NSString *)itemItunesLink;
@end
