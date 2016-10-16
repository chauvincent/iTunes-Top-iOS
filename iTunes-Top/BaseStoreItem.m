//
//  BaseStoreItem.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "BaseStoreItem.h"

@implementation BaseStoreItem


- (instancetype)initWithName:(NSString *)itemName
                   andAuthor:(NSString *)itemAuthor
                   withPrice:(NSString *)itemPrice
                  andContent:(NSString *)itemContentType
                  inCategory:(NSString *)itemCategoryType
{
    
    if (self = [super init])
    {
        name = itemName;
        author = itemAuthor;
        price = itemPrice;
        contentType = itemContentType;
        categoryType = itemCategoryType;
    }
    
    return self;
}


@end
