//
//  ARShowMoreVC.m
//  ARBaisibudejie
//
//  Created by andyron<http://andyron.com> on 2017/11/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ARShowMoreVC.h"
#import "ARMoreCell.h"
#import "ARMoreLayout.h"
#import "UIView+ARSegment.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ARShowMoreVC ()
@property (nonatomic, strong) ARSegmentConfig *segmentConfig;
@property (nonatomic, strong) ARMoreLayout *waterLayout;
@end

@implementation ARShowMoreVC

static NSString * const reuseIdentifier = @"MoreCell";

- (ARMoreLayout *)waterLayout {
    if (_waterLayout == nil) {
        _waterLayout = [[ARMoreLayout alloc] init];
        __weak typeof(self) weakSelf = self;
        [_waterLayout computeIndexCellHeightWithWidthBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            NSString *str = (NSString *)weakSelf.items[indexPath.item];
            CGRect rect= [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:weakSelf.segmentConfig.showMoreCellFont} context:nil];
            //NSLog(@"%@,%f,%@",weakSelf.segmentConfig.showMoreCellFont,rect.size.height,str);
            return rect.size.height;
        }];
        _waterLayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    }
    return _waterLayout;
}

-(void)setItems:(NSArray<NSString *> *)items{
    _items = items;
    [self.collectionView reloadData];
}

- (instancetype)initWithConfig : (ARSegmentConfig *)segmentConfig{
    self.segmentConfig = segmentConfig;
    
    self.waterLayout.minimumLineSpacing = self.segmentConfig.limitMargin;
    self.waterLayout.minimumInteritemSpacing = self.segmentConfig.limitMargin;
    self.waterLayout.cols = self.segmentConfig.showMoreVCRowCount;
    self.waterLayout.minCellH = self.segmentConfig.showMoreCellMinH;
    return [super initWithCollectionViewLayout:self.waterLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib * nib = [UINib nibWithNibName:@"ARMoreCell" bundle: [NSBundle mainBundle]];
    
    //NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
    //UINib *nib = [UINib nibWithNibName:@"ARMoreCell" bundle:currentBundle];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ARMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.menuLabel.text = (NSString *)self.items[indexPath.row];
    cell.backgroundColor = cell.selected ? self.segmentConfig.segSelectedColor : self.segmentConfig.showMoreCellBGColor;
    cell.segmentConfig = self.segmentConfig;
    return cell;
}

@end
