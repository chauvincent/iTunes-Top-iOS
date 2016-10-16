//
//  ViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/13/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "FeaturedCollectionViewController.h"
#import "CategoryCollectionViewCell.h"

@interface FeaturedCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation FeaturedCollectionViewController

static NSString * const cellId = @"CategoryCell";

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self setupCollectionView];

}

#pragma mark - Setup View

- (void)setupView
{
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    self.navigationItem.title = @"Featured";
}

- (void)setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:cellId];
}

#pragma mark - <UICollectionViewDelegate>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, 200.0f);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView setNeedsDisplay];
}

@end
