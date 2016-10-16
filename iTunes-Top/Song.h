//
//  Song.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/16/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "BaseStoreItem.h"

@interface Song : BaseStoreItem

@property (strong, nonatomic) NSString *imageLink;
@property (strong, nonatomic) NSString *previewLink;

@end
