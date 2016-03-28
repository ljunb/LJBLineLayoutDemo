//
//  LJBLineLayout.m
//  LJBLineLayoutDemo
//
//  Created by CookieJ on 16/3/28.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBLineLayout.h"

@implementation LJBLineLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat width = self.collectionView.frame.size.width * 0.7;
    CGFloat height = self.collectionView.frame.size.height * 0.9;
    self.itemSize = CGSizeMake(width, height);
    
    CGFloat horizontalInset = (self.collectionView.frame.size.width - width) * 0.5;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, horizontalInset, 0, horizontalInset);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    NSArray * attrsArray = [[NSArray alloc] initWithArray:array copyItems:YES];
    
    CGFloat collectionViewCenterX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    [attrsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        UICollectionViewLayoutAttributes * attrs = (UICollectionViewLayoutAttributes *)obj;
        
        CGFloat distance = ABS(attrs.center.x - collectionViewCenterX);
        
        CGFloat scale = 1 - distance / self.collectionView.frame.size.width / 3.5;
        
        attrs.transform = CGAffineTransformMakeScale(scale, scale);
    }];
    
    
    return attrsArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    
    NSArray * attrsArray = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat collectionViewCenterX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    __block CGFloat minDistance = MAXFLOAT;
    [attrsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UICollectionViewLayoutAttributes * attrs = (UICollectionViewLayoutAttributes *)obj;
        
        if (ABS(minDistance) > ABS(attrs.center.x - collectionViewCenterX)) {
            minDistance = attrs.center.x - collectionViewCenterX;
        }
    }];
    
    proposedContentOffset.x += minDistance;
    
    return proposedContentOffset;
}




@end
