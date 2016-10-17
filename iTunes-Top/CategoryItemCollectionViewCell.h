//
//  CategoryItemCollectionViewCell.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/15/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseStoreItem.h"

@interface CategoryItemCollectionViewCell : UICollectionViewCell

- (void)configureItemInfo:(BaseStoreItem *)item;

@end
