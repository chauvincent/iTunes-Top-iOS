//
//  StoreItemTableViewCell.h
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreItemTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *numberLabel;
@property (strong, nonatomic) UIImageView *itemImageView;
@property (strong, nonatomic) UILabel *nameLabel;

- (void)setImage:(NSString *)imageLink;

@end
