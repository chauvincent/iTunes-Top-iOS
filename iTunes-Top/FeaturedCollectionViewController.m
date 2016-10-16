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

@property (strong, nonatomic) NSArray *categoryTitles;

@end

@implementation FeaturedCollectionViewController

static NSString * const cellId = @"CategoryCell";

#pragma mark - Lazy Init

- (NSArray *)categoryTitles
{
    
    if (!_categoryTitles)
    {
        _categoryTitles = @[@"Top 10 Songs",@"Top 10 AudioBooks",@"Top 10 iTunes U Collection"];
    }
    
    return _categoryTitles;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - Setup View

- (void)setupView
{
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    self.navigationItem.title = @"Featured";
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:cellId];
}

#pragma mark - <UICollectionViewDelegate>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.categoryLabel.text = self.categoryTitles[indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.categoryTitles count];
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
