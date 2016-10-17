//
//  CategoryItemCollectionViewCell.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/15/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "CategoryItemCollectionViewCell.h"
#import "NetworkManager.h"
#import "BaseStoreItem.h"
#import "AudioBook.h"
#import "iTunesUCollection.h"
#import "Song.h"

@interface CategoryItemCollectionViewCell ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *priceLabel;

@end

@implementation CategoryItemCollectionViewCell

#pragma mark - Lazy Init

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
//        _imageView.image = [UIImage imageNamed:@"test"];
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
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width + 5, self.frame.size.width, 40.0f)];
        _titleLabel.font = [UIFont systemFontOfSize:12.0f];
        _titleLabel.text = @"PlaceHolder MUsic stuff";
        _titleLabel.numberOfLines = 2;
        
    }
    
    return _titleLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel)
    {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width + self.titleLabel.frame.size.height, self.frame.size.width, 10.0f)];
        _descriptionLabel.font = [UIFont systemFontOfSize:10.0f];
        _descriptionLabel.textColor = [UIColor grayColor];
        _descriptionLabel.text = @"Electronica";
        _descriptionLabel.numberOfLines = 1;
        
    }
    
    return _descriptionLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.width + self.descriptionLabel.frame.size.height + self.titleLabel.frame.size.height, self.frame.size.width, 10.0f)];
        _priceLabel.font = [UIFont systemFontOfSize:10.0f];
        _priceLabel.textColor = [UIColor grayColor];
        _priceLabel.text = @"FREE";
        _priceLabel.numberOfLines = 1;
        
    }
    
    return _priceLabel;
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

#pragma mark - Setup View

- (void)setupViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.priceLabel];
}

#pragma mark - Helpers

- (void)configureItemInfo:(BaseStoreItem *)item
{
    
    self.titleLabel.text = item.name;
    self.descriptionLabel.text = item.categoryType;
   
    if ([item.price isEqualToString: @"0"])
    {
        self.priceLabel.text = @"FREE";
    }
    else
    {
        self.priceLabel.text = [NSString stringWithFormat:@"$%@", item.price];
    }
    
    NSString *imageLink = [self getImageString:item];

    [NetworkManager downloadImagesWithUrl:imageLink withCompletion:^(UIImage *image, bool success) {
    
        self.imageView.image = image;
    
    }];
}

- (NSString *)getImageString:(BaseStoreItem *)item
{
    if ([item isKindOfClass:[AudioBook class]])
    {
        return ((AudioBook *)item).imageLink;
    }
    else if ([item isKindOfClass:[iTunesUCollection class]])
    {
        return ((iTunesUCollection *)item).imageLink;
    }
    else
    {
        return ((Song *)item).imageLink;
    }
}
@end

