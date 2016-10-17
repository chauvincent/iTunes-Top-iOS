//
//  CategoryCollectionViewCell.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/15/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import "CategoryItemCollectionViewCell.h"
#import "UIView+Constraints.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "ItemDetailView.h"
#import "PreviewAudioView.h"
#import "BaseStoreItem.h"
#import "Song.h"
#import "AudioBook.h"
#import "iTunesUCollection.h"


@interface CategoryCollectionViewCell () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) PreviewAudioView *previewView;
@property (strong, nonatomic) ItemDetailView *itemView;

@end

@implementation CategoryCollectionViewCell

static NSString * const cellId = @"ItemCell";

#pragma mark - Lazy Init

- (PreviewAudioView *)previewView
{
    if (!_previewView)
    {
        _previewView = [[PreviewAudioView alloc] init];
    }
    return _previewView;
}

-(ItemDetailView *)itemView
{
    if (!_itemView)
    {
        _itemView = [[ItemDetailView alloc] init];
    }
    return _itemView;
}


- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _collectionView;
}

- (UILabel *)categoryLabel
{
    if (!_categoryLabel)
    {
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.font = [UIFont systemFontOfSize:15.0f];
        _categoryLabel.backgroundColor = [UIColor whiteColor];
        _categoryLabel.text = @"Category";
        _categoryLabel.numberOfLines = 2;
        _categoryLabel.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    return _categoryLabel;
}

#pragma mark - View Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setupView];
    }
    
    return self;
}

#pragma mark - View Setup

- (void)setupView
{
    self.backgroundColor = [UIColor clearColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CategoryItemCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [self addSubview:self.collectionView];
    
    // Collection View Constraints
    [self addVisualConstraintWithFormat:@"H:|-8-[v0]-8-|" andView:@[self.collectionView]];

    // Add Bottom Hairline to Bottom of Cell
    UIView *bottomHairline = [[UIView alloc] init];
    [self addSubview:bottomHairline];
    bottomHairline.backgroundColor = [UIColor grayColor];
    bottomHairline.translatesAutoresizingMaskIntoConstraints = false;
    
    // Hairline Constraints
    [bottomHairline.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [bottomHairline.heightAnchor constraintEqualToConstant:0.4f].active = YES;
    [bottomHairline.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    
    [self addSubview:self.categoryLabel];
    
    // Category Title and Collection View Constraints
    [self addVisualConstraintWithFormat:@"V:|[v0(30)][v1]|" andView:@[self.categoryLabel, self.collectionView]];
    [self addVisualConstraintWithFormat:@"H:|-8-[v0]|" andView:@[self.categoryLabel]];
    
}

#pragma mark - Update Model

- (void)configureItems:(NSMutableArray *)topItems
{
    self.items = topItems;
    [self.collectionView reloadData];
}

#pragma mark - <UICollectionViewDelegate>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell configureItemInfo:self.items[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = self.items[indexPath.row];
    
    if ([item isKindOfClass:[AudioBook class]] || [item isKindOfClass:[Song class]])
    {
        [self.previewView showMenu:item];
    }
    else
    {
        NSLog(@"show course");
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = [self.items count];
    
    // Show only top 10
    return (count != 0) ? 10 : 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100.0f, self.frame.size.height - 32);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


@end
