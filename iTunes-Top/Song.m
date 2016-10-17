//
//  Song.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "Song.h"

@implementation Song

@synthesize imageLink;
@synthesize previewLink;

- (instancetype)initWithName:(NSString *)itemName
                   andAuthor:(NSString *)itemAuthor
                   withPrice:(NSString *)itemPrice
                  andContent:(NSString *)itemContentType
                  inCategory:(NSString *)itemCategoryType
                   andItunes:(NSString *)itemItunesLink
                    andImage:(NSString *)itemImageLink
                 withPreview:(NSString *)itemPreviewLink
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
        previewLink = itemPreviewLink;
    }
    
    return self;
}

@end
