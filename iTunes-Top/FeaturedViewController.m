//
//  ViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/13/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "FeaturedViewController.h"
#import "CategoryCollectionViewCell.h"
#import "JSONParser.h"
#import "NetworkManager.h"

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
    [self setupModel];
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

#pragma mark - Setup Model

- (void)setupModel
{
    JSONParser *parser = [[JSONParser alloc] init];
    dispatch_group_t serviceGroup = dispatch_group_create();
    dispatch_group_enter(serviceGroup);
 
    // Top Songs
    [NetworkManager getDataFromEndpoint:@"https://itunes.apple.com/us/rss/topitunesucollections/limit=100/json" withCompletion:^(bool success, NSArray *entry) {
            [parser parseCollectionJSONWithEntry:entry withCompletion:^(NSMutableArray *collection) {
                [self.allCategory addObject:collection];
                dispatch_group_leave(serviceGroup);
        }];
    }];
    
    dispatch_group_enter(serviceGroup);
    
    // Top Songs
    [NetworkManager getDataFromEndpoint:@"https://itunes.apple.com/us/rss/topsongs/limit=100/json" withCompletion:^(bool success, NSArray *entry) {
            [parser parseSongJSONWithEntry:entry withCompletion:^(NSMutableArray *allSongs) {
                [self.allCategory addObject:allSongs];
                dispatch_group_leave(serviceGroup);
        }];
    }];
    
    dispatch_group_enter(serviceGroup);
    
    // Top AudioBooks
    [NetworkManager getDataFromEndpoint:@"https://itunes.apple.com/us/rss/topaudiobooks/limit=100/json" withCompletion:^(bool success, NSArray *entry) {
            [parser parseAudioBookJSONWithEntry:entry withCompletion:^(NSMutableArray *allAudioBooks) {
                    [self.allCategory addObject:allAudioBooks];
                dispatch_group_leave(serviceGroup);
            }];
    }];
    
    // All Tasks Finished
    dispatch_group_notify(serviceGroup,dispatch_get_main_queue(),^{
        [self.collectionView reloadData];
    });
}


@end
