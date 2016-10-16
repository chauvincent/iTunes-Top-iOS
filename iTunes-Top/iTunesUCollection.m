//
//  iTunesUCollection.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "iTunesUCollection.h"

@implementation iTunesUCollection

- (instancetype)initWithName:(NSString *)itemName
                   andAuthor:(NSString *)itemAuthor
                   withPrice:(NSString *)itemPrice
                  andContent:(NSString *)itemContentType
                  inCategory:(NSString *)itemCategoryType
                    andImage:(NSString *)itemImageLink
                 withPreview:(NSString *)itemSummary
{
    
    if (self = [super init])
    {
        name = itemName;
        author = itemAuthor;
        price = itemPrice;
        contentType = itemContentType;
        categoryType = itemCategoryType;
        imageLink = itemImageLink;
        summary = itemSummary;
    }
    
    return self;
}


@end
