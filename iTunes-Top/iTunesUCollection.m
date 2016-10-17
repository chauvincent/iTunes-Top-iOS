//
//  iTunesUCollection.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "iTunesUCollection.h"

@implementation iTunesUCollection

@synthesize imageLink;
@synthesize summary;

- (instancetype)initWithName:(NSString *)itemName
                   andAuthor:(NSString *)itemAuthor
                   withPrice:(NSString *)itemPrice
                  andContent:(NSString *)itemContentType
                  inCategory:(NSString *)itemCategoryType
                   andItunes:(NSString *)itemItunesLink
                    andImage:(NSString *)itemImageLink
                 withSummary:(NSString *)itemSummary
{
    
    if (self = [super init])
    {
        name = itemName;
        author = itemAuthor;
        price = itemPrice;
        contentType = itemContentType;
        categoryType = itemCategoryType;
        iTunesLink = itemItunesLink;
        imageLink = itemImageLink;
        summary = itemSummary;
    }
    
    return self;
}


@end
