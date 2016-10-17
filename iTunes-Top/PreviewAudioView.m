//
//  PreviewAudioView.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/17/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "PreviewAudioView.h"
#import "UIView+Constraints.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface PreviewAudioView()

@property (strong, nonatomic) UIView *dimBackground;
@property (strong, nonatomic) UIView *informationContainer;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *forwardButton;
@property (strong, nonatomic) UIButton *rewindButton;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (assign) BOOL isPlaying;

@end

@implementation PreviewAudioView

#pragma mark - Lazy Init

- (UIButton *)playButton
{
    if (!_playButton)
    {
        _playButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _playButton.translatesAutoresizingMaskIntoConstraints = false;
        self.isPlaying = false;
    }
    return _playButton;
}

- (UIButton *)forwardButton
{
    if (!_forwardButton)
    {
        _forwardButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _forwardButton.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _forwardButton;
}

- (UIButton *)rewindButton
{
    if (!_rewindButton)
    {
        _rewindButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _rewindButton.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _rewindButton;
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

- (void)showMenu
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
    
    // Play Button
    [self.informationContainer addSubview:self.playButton];
    [self.playButton.topAnchor constraintEqualToAnchor:bottomHairline.bottomAnchor constant:10.0f].active = YES;
    [self.playButton.centerXAnchor constraintEqualToAnchor:self.informationContainer.centerXAnchor].active = YES;
    [self.playButton.heightAnchor constraintEqualToConstant:50.0f].active = YES;
    [self.playButton.widthAnchor constraintEqualToConstant:50.0f].active = YES;
    UIImage *playButonImage = [[UIImage imageNamed:@"play_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.playButton setBackgroundImage:playButonImage forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(togglePlay:) forControlEvents:UIControlEventTouchUpInside];
    
    // Forward Button Constraints
    [self.informationContainer addSubview:self.forwardButton];
    [self.forwardButton.centerYAnchor constraintEqualToAnchor:self.playButton.centerYAnchor].active = YES;
    [self.forwardButton.leftAnchor constraintEqualToAnchor:self.playButton.rightAnchor constant:10.0f].active = YES;
    [self.forwardButton.heightAnchor constraintEqualToConstant:30.0f].active = YES;
    [self.forwardButton.widthAnchor constraintEqualToConstant:30.0f].active = YES;
    
    // Forward Button Images
    UIImage *forwardImage = [[UIImage imageNamed:@"fastforward_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.forwardButton setBackgroundImage:forwardImage forState:UIControlStateNormal];
    
    
    // Rewind Button
    [self.informationContainer addSubview:self.rewindButton];
    
    // Rewind Button Constraints
    [self.rewindButton.centerYAnchor constraintEqualToAnchor:self.playButton.centerYAnchor].active = YES;
    [self.rewindButton.rightAnchor constraintEqualToAnchor:self.playButton.leftAnchor constant:-10.0f].active = YES;
    [self.rewindButton.heightAnchor constraintEqualToConstant:30.0f].active = YES;
    [self.rewindButton.widthAnchor constraintEqualToConstant:30.0f].active = YES;
    
    // Rewind Image
    UIImage *rewindImage = [[UIImage imageNamed:@"rewind_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.rewindButton setBackgroundImage:rewindImage forState:UIControlStateNormal];
    
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
            if (self.isPlaying)
            {
                [self.player stop];
                self.isPlaying = false;
            }
            
            [self.dimBackground removeFromSuperview];
            [self.informationContainer removeFromSuperview];
        }
    }];
}

#pragma mark - Toggle Action

-(void)togglePlay:(UIButton*)sender
{
    if (!self.isPlaying)
    {

        UIImage *pauseImage = [[UIImage imageNamed:@"pause_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.playButton setBackgroundImage:pauseImage forState:UIControlStateNormal];
        
        NSURL *url = [NSURL URLWithString:@"http://audio.itunes.apple.com/apple-assets-us-std-000001/AudioPreview62/v4/bd/6b/34/bd6b3443-d4c3-26fd-91c8-d0b31ab47ee3/mzaf_8046559398209773051.plus.aac.p.m4a"];
        
        NSData *soundData = [NSData dataWithContentsOfURL:url];
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask, YES) objectAtIndex:0]
                                  stringByAppendingPathComponent:@"sound.caf"];
        [soundData writeToFile:filePath atomically:YES];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:NULL];
        [self.player play];
        self.isPlaying = true;
    }
    else
    {
        [self.player pause];
        UIImage *playButonImage = [[UIImage imageNamed:@"play_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        [self.playButton setBackgroundImage:playButonImage forState:UIControlStateNormal];
        self.isPlaying = false;

    }
    
}
@end
