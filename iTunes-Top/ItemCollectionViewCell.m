//
//  ItemCollectionViewCell.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/15/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "ItemCollectionViewCell.h"

@interface ItemCollectionViewCell ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation ItemCollectionViewCell

#pragma mark - Lazy Inits

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imageView.image = [UIImage imageNamed:@"test"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 20.0f;
        _imageView.layer.masksToBounds = true;
        _imageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width + 2, self.frame.size.width, 40.0f)];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.text = @"PlaceHolder MUsic stuff";
        _titleLabel.numberOfLines = 2;
        _titleLabel.backgroundColor = [UIColor blackColor];
    }
    return _titleLabel;
}

#pragma mark - View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}

@end

