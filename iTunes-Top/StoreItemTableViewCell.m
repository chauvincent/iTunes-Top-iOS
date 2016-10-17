//
//  StoreItemTableViewCell.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "StoreItemTableViewCell.h"
#import "UIView+Constraints.h"
#import "NetworkManager.h"

@implementation StoreItemTableViewCell

- (UILabel *)numberLabel
{
    if (!_numberLabel)
    {
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _numberLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

- (UIImageView *)itemImageView
{
    if (!_itemImageView)
    {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _itemImageView.contentMode = UIViewContentModeScaleAspectFill;
        _itemImageView.layer.cornerRadius = 20.0f;
        _itemImageView.layer.masksToBounds = true;
        _itemImageView.backgroundColor = [UIColor grayColor];
        _itemImageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _itemImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self addSubview:self.itemImageView];
    [self.itemImageView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:50.0f].active = YES;
    [self.itemImageView.heightAnchor constraintEqualToConstant:100.0f].active = YES;
    [self.itemImageView.widthAnchor constraintEqualToConstant:100.0f].active = YES;
    [self.itemImageView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    
    [self addSubview:self.numberLabel];
    [self.numberLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10.0f].active = YES;
    [self.numberLabel.widthAnchor constraintEqualToConstant:35.0f].active = YES;
    [self.numberLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.numberLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    
    [self addSubview:self.nameLabel];
    [self.nameLabel.leftAnchor constraintEqualToAnchor:self.itemImageView.rightAnchor constant:10.0f].active = YES;
    [self.nameLabel.centerYAnchor constraintEqualToAnchor:self.itemImageView.centerYAnchor].active = YES;
    [self.nameLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-10.0f].active = YES;

}

- (void)setImage:(NSString *)imageLink
{
    [NetworkManager downloadImagesWithUrl:imageLink withCompletion:^(UIImage *image, bool success) {
        self.itemImageView.image = image;
        
    }];
}

@end
