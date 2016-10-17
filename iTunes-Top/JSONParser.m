//
//  JSONParser.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "JSONParser.h"
#import "BaseStoreItem.h"
#import "Song.h"
#import "iTunesUCollection.h"
#import "AudioBook.h"

@implementation JSONParser

- (instancetype)init
{
    if (self = [super init])
    {
        
    }
    
    return self;
}



- (void)parseCollectionJSONWithEntry:(NSArray *)entries withCompletion:(void (^)(NSMutableArray *collection))block
{
    NSMutableArray *allCollections = [NSMutableArray array];
    for (NSDictionary *dict in entries)
    {
        BaseStoreItem *item = [self parseForBaseComponent:dict];

        // Collection Summary
        NSString *summary = ((NSDictionary *)dict[@"summary"])[@"label"];
        
        // Image Link
        NSArray *imageInfo = (NSArray *)(dict[@"im:image"]);
        NSDictionary *largeImageInfo = imageInfo.lastObject;
        NSString *imageLink = largeImageInfo[@"label"];
        
        iTunesUCollection *collection = [[iTunesUCollection alloc] initWithName:item.name andAuthor:item.author withPrice:item.price andContent:item.contentType inCategory:item.categoryType andItunes:item.iTunesLink andImage:imageLink withSummary:summary];
        [allCollections addObject:collection];
    }
    block(allCollections);
}

- (BaseStoreItem *)parseForBaseComponent:(NSDictionary *)dictionary
{
    // Name
    NSString *name = ((NSDictionary *)dictionary[@"im:name"])[@"label"];
    
    // Author
    NSString *author = ((NSDictionary *)dictionary[@"im:artist"])[@"label"];
    
    // Content Type
    NSDictionary *contentAttr = ((NSDictionary *)dictionary[@"im:contentType"])[@"attributes"];
    NSString *contentType = contentAttr[@"term"];
    
    // Price
    NSDictionary *priceInfo = ((NSDictionary *)dictionary[@"im:price"])[@"attributes"];
    NSString *price = priceInfo[@"amount"];
    
    // CategoryName
    NSDictionary *categoryInfo = ((NSDictionary *)dictionary[@"category"])[@"attributes"];
    NSString *categoryName = categoryInfo[@"term"];
    
    // iTunes Link
    NSString *iTunesLink = ((NSDictionary *)dictionary[@"id"])[@"label"];
    
    return [[BaseStoreItem alloc] initWithName:name andAuthor:author withPrice:price andContent:contentType inCategory:categoryName andItunes:iTunesLink];
}
@end
