//
//  ViewController.m
//  iTunes-Top
//
//  Created by Vincent Chau on 10/13/16.
//  Copyright © 2016 Vincent Chau. All rights reserved.
//

#import "FeaturedCollectionViewController.h"
#import "CategoryCollectionViewCell.h"
#import "JSONParser.h"

@interface FeaturedCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *categoryTitles;

@property (strong, nonatomic) NSMutableArray *topSongs;
@property (strong, nonatomic) NSMutableArray *topAudioBooks;
@property (strong, nonatomic) NSMutableArray *topCollection;
@property (strong, nonatomic) NSArray *allCategory;

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
- (NSArray *)allCategory
{
    if (!_allCategory)
    {
        _allCategory = @[self.topSongs,self.topAudioBooks, self.topCollection];
    }
    return _allCategory;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self loadTestJSON];
}

#pragma mark - Test JSON

- (void)loadTestJSON
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"topCollection" ofType:@"json"];
    NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
    NSDictionary *feedDict = jsonDict[@"feed"];
    NSArray *entry = feedDict[@"entry"];
    
    JSONParser *parser = [[JSONParser alloc] init];
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        // block1
        NSLog(@"Block1");
        [parser parseCollectionJSONWithEntry:entry withCompletion:^(NSMutableArray *collection) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.topCollection = collection;
            });
    
        }];
        NSLog(@"Block1 End");
    });
    
    
    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        // block2
        NSLog(@"Block2");
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"Block2 End");
    });
    
    dispatch_group_notify(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        // block3
        NSLog(@"Block3");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
   
        });
    
        
    });

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
    [cell configureItems:self.topCollection];
    
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

#pragma mark - Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView setNeedsDisplay];
}

@end
