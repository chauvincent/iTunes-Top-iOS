//
//  ItemDetailView.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "ItemDetailView.h"
#import "UIView+Constraints.h"

@interface ItemDetailView()

@property (strong, nonatomic) UIView *dimBackground;
@property (strong, nonatomic) UIView *informationContainer;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;

@end

@implementation ItemDetailView

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
    [self.titleLabel.rightAnchor constraintEqualToAnchor:self.informationContainer.rightAnchor].active = YES;
    
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
    
    self.dimBackground.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.dimBackground.alpha = 1.0f;
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
