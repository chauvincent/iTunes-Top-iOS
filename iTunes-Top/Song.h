//
//  Song.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "BaseStoreItem.h"

@interface Song : BaseStoreItem
{
    NSString *imageLink;
    NSString *previewLink;
}

@property (readonly) NSString *imageLink;
@property (readonly) NSString *previewLink;

- (instancetype)initWithName:(NSString *)itemName
                   andAuthor:(NSString *)itemAuthor
                   withPrice:(NSString *)itemPrice
                  andContent:(NSString *)itemContentType
                  inCategory:(NSString *)itemCategoryType
                   andItunes:(NSString *)itemItunesLink
                    andImage:(NSString *)itemImageLink
                 withPreview:(NSString *)itemPreviewLink;

@end
