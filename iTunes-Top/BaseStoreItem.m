//
//  BaseStoreItem.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "BaseStoreItem.h"

@implementation BaseStoreItem


- (instancetype)initWithName:(NSString *)name
                   andAuthor:(NSString *)author
                   withPrice:(NSString *)price
                  andContent:(NSString *)contentType
                  inCategory:(NSString *)categoryType
{
    
    if (self = [super init])
    {
        _name = name;
        _author = author;
        _price = price;
        _contentType = contentType;
        _categoryType = categoryType;
    }
    
    return self;
}


@end
