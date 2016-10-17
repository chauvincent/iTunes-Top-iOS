//
//  ViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/15/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "FeaturedViewController.h"
#import "CategoryCollectionViewCell.h"
#import "JSONParser.h"
#import "NetworkManager.h"
#import "Constants.h"

@interface FeaturedViewController () <UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *categoryTitles;
@property (strong, nonatomic) NSMutableArray *allCategory;

@end

@implementation FeaturedViewController

static NSString * const cellId = @"CategoryCell";

#pragma mark - Lazy Init

- (NSMutableArray *)allCategory
{
    if (!_allCategory)
    {
        _allCategory = [NSMutableArray array];
    }
    return _allCategory;
}


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
    
    // Subscribe to RootTabBar's Finished All Downloads Notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedDownload:) name:kObserverFinishedAll object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kObserverFinishedAll object:nil];
}

#pragma mark - Setup View

- (void)setupView
{
    self.navigationItem.title = @"Featured";
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
}


#pragma mark - <UICollectionViewDelegate>

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.categoryLabel.text = self.categoryTitles[indexPath.row];
    
    if ([self.allCategory count] != 0)
    {
        [cell configureItems:self.allCategory[indexPath.row]];
    }
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([self.allCategory count] == 0)
    {
        return 0;
    }
    
    return [self.categoryTitles count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, 200.0f);
}

#pragma mark - Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView setNeedsDisplay];
}


#pragma mark - NSNotificationCenter

- (void)finishedDownload:(NSNotification *)notification
{
    if ([notification.object isKindOfClass:[NSMutableArray class]])
    {
        NSMutableArray *allObjects = [notification object];
        self.allCategory = allObjects;
        [[NSNotificationCenter defaultCenter] postNotificationName:kObserverFinishedCollection object:self.allCategory.lastObject];
        
        [self.collectionView reloadData];
    }
    else
    {
        NSLog(@"Observer Did Not Get Caught");
    }
}


@end
