//
//  ItemDetailView.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "ItemDetailView.h"
#import "UIView+Constraints.h"
#import "NetworkManager.h"

@interface ItemDetailView()

@property (strong, nonatomic) UIView *dimBackground;
@property (strong, nonatomic) UIView *informationContainer;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UITextView *summaryTextView;

@property (strong, nonatomic) UIButton *closeButton;

@end

@implementation ItemDetailView

#pragma mark - Lazy Init

- (UIButton *)closeButton
{
    if (!_closeButton)
    {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _closeButton.tintColor = [UIColor grayColor];
        _closeButton.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _closeButton;
}


- (UITextView *)summaryTextView
{
    if (!_summaryTextView)
    {
        _summaryTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _summaryTextView.translatesAutoresizingMaskIntoConstraints = false;
        _summaryTextView.selectable = false;
        _summaryTextView.editable = false;
    }
    return _summaryTextView;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel)
    {
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descriptionLabel.font = [UIFont systemFontOfSize:10.0f];
        _descriptionLabel.text = @"Author";
        _descriptionLabel.textColor = [UIColor grayColor];
        _descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
        _descriptionLabel.numberOfLines = 1;
    }
    return _descriptionLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"Really Long Song Name Like This";
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.cornerRadius = 20.0f;
        _imageView.layer.masksToBounds = true;
        _imageView.backgroundColor = [UIColor grayColor];
        _imageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _imageView;
}

#pragma mark - View Lifecycle

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}


- (void)showMenu:(BaseStoreItem *)item
{
    
    // Dim Background
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    self.dimBackground = [[UIView alloc] initWithFrame:CGRectZero];
    self.dimBackground.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.dimBackground.translatesAutoresizingMaskIntoConstraints = false;
    [window addSubview:self.dimBackground];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu:)];
    [self.dimBackground addGestureRecognizer:tapRecognizer];
    
    // Dim Background Constraints
    [window addVisualConstraintWithFormat:@"H:|[v0]|" andView:@[self.dimBackground]];
    [window addVisualConstraintWithFormat:@"V:|[v0]|" andView:@[self.dimBackground]];
    
    // Setup Info View
    self.informationContainer = [[UIView alloc] initWithFrame:CGRectZero];
    self.informationContainer.backgroundColor = [UIColor whiteColor];
    self.informationContainer.layer.cornerRadius = 20.0f;
    
    // Info View Constraints;
    [window addSubview:self.informationContainer];
    self.informationContainer.translatesAutoresizingMaskIntoConstraints = false;
    [window addVisualConstraintWithFormat:@"H:|-30-[v0]-30-|" andView:@[self.informationContainer]];
    [window addVisualConstraintWithFormat:@"V:|-30-[v0]-30-|" andView:@[self.informationContainer]];
    
    
    // Setup Image View
    [self.informationContainer addSubview:self.imageView];
    
    // Image View Constraints
    [self.imageView.heightAnchor constraintEqualToConstant:100.0f].active = YES;
    [self.imageView.widthAnchor constraintEqualToConstant:100.0f].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.informationContainer.topAnchor constant:10.0f].active = YES;
    [self.imageView.leftAnchor constraintEqualToAnchor:self.informationContainer.leftAnchor constant:10.0f].active = YES;
    
    [self.informationContainer addSubview:self.titleLabel];
    
    // Setup Name Label
    [self.titleLabel.leftAnchor constraintEqualToAnchor:self.imageView.rightAnchor constant:10.0f].active = YES;
    [self.titleLabel.topAnchor constraintEqualToAnchor:self.imageView.topAnchor].active = true;
    [self.titleLabel.rightAnchor constraintEqualToAnchor:self.informationContainer.rightAnchor constant:-10.0f].active = YES;
    // Setup Author Label
    [self.informationContainer addSubview:self.descriptionLabel];
    [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor].active = YES;
    [self.descriptionLabel.leftAnchor constraintEqualToAnchor:self.imageView.rightAnchor constant:10.0f].active = YES;
    [self.descriptionLabel.rightAnchor constraintEqualToAnchor:self.informationContainer.rightAnchor].active = YES;
    
    
    // Add Bottom Hairline to Bottom of Cell
    UIView *bottomHairline = [[UIView alloc] init];
    [self.informationContainer addSubview:bottomHairline];
    bottomHairline.backgroundColor = [UIColor grayColor];
    bottomHairline.translatesAutoresizingMaskIntoConstraints = false;
    
    // Hairline Constraints
    [bottomHairline.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:10.0f].active = YES;
    [bottomHairline.heightAnchor constraintEqualToConstant:0.4f].active = YES;
    [bottomHairline.leftAnchor constraintEqualToAnchor:self.informationContainer.leftAnchor].active = YES;
    [bottomHairline.widthAnchor constraintEqualToAnchor:self.informationContainer.widthAnchor].active = YES;
    
    // Setup Summary Text View
    self.summaryTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    [self.informationContainer addSubview:self.summaryTextView];
    
    // Summary Text View Constraints
    [self.summaryTextView.topAnchor constraintEqualToAnchor:bottomHairline.bottomAnchor].active = YES;
    [self.informationContainer addVisualConstraintWithFormat:@"H:|-10-[v0]-10-|" andView:@[self.summaryTextView]];
    [self.summaryTextView.bottomAnchor constraintEqualToAnchor:self.informationContainer.bottomAnchor].active = YES;
    
    // Close Button
    [self.informationContainer addSubview:self.closeButton];
    UIImage *closeImage = [[UIImage imageNamed:@"dismiss_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.closeButton addTarget:self action:@selector(dismissMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton.bottomAnchor constraintEqualToAnchor:self.informationContainer.bottomAnchor constant:-10.0f].active = YES;
    [self.closeButton.centerXAnchor constraintEqualToAnchor:self.informationContainer.centerXAnchor].active = YES;
    [self.closeButton.heightAnchor constraintEqualToConstant:30.0f].active = YES;
    [self.closeButton.widthAnchor constraintEqualToConstant:30.0f].active = YES;
    [self.closeButton setBackgroundImage:closeImage forState:UIControlStateNormal];
    
    // Setup Item
    if ([item isKindOfClass:[iTunesUCollection class]])
    {
        iTunesUCollection *collection = (iTunesUCollection *)item;
        self.titleLabel.text = collection.name;
        self.descriptionLabel.text = collection.author;
        self.summaryTextView.text = collection.summary;
        [self setupImageView:collection.imageLink];
    }
    
    self.dimBackground.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.dimBackground.alpha = 1.0f;
    }];
}

#pragma mark - Helpers

- (void)setupImageView:(NSString *)url
{
    // Image should already be in cache. Look up and download if not in cache just incase.
    [NetworkManager downloadImagesWithUrl:url withCompletion:^(UIImage *image, bool success) {
        self.imageView.image = image;
    }];
}
#pragma mark - Dismiss Action

- (void)dismissMenu:(id)sender
{
    self.dimBackground.alpha = 1.0f;
    self.informationContainer.alpha = 1.0f;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.dimBackground.alpha = 0.0f;
        self.informationContainer.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        if (finished)
        {
            [self.dimBackground removeFromSuperview];
            [self.informationContainer removeFromSuperview];
        }
    }];
}

@end
