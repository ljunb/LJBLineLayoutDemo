//
//  ViewController.m
//  LJBLineLayoutDemo
//
//  Created by CookieJ on 16/3/28.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "ViewController.h"
#import "LJBLineLayout.h"

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;

@end


static NSString * const kLJBSectorCellIdentifier = @"LJBSectorCellIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"仿想去首页布局";
    
    self.collectionView.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height * 0.7);
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kLJBSectorCellIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLJBSectorCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        LJBLineLayout * layout = [[LJBLineLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end

