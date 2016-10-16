//
//  CategoryCollectionViewCell.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/15/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import "ItemCollectionViewCell.h"

@interface CategoryCollectionViewCell () <UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation CategoryCollectionViewCell

static NSString * const cellId = @"ItemCell";

#pragma mark - Lazy Init

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blueColor];
        _collectionView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _collectionView;
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

- (void)setupView
{
    self.backgroundColor = [UIColor redColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ItemCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [self addSubview:self.collectionView];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[v0]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"v0":self.collectionView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v0]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"v0":self.collectionView}]];

    
}

#pragma mark - <UICollectionViewDelegate>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

#pragma mark - Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView setNeedsDisplay];
}

@end