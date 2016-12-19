//
//  DropDownTableList.h
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"

@class DropDownTableList;
@protocol DropDownTableListDelegate <NSObject>


@end

@protocol DropDownTableListDataSource <NSObject>
@required
-(NSInteger)dropDownTableList:(DropDownTableList *)dropDownTableList numberOfRowsInSection:(NSInteger)section;
//-(UITableViewCell *)dropDownTableList:(DropDownTableList *)dropDownTableList cellForRowAtIndexPath:(NSIndexPath *)indexPah;
-(UIView *)dropDownTableList:(DropDownTableList *)dropDownTableList contentViewForCell:(UIView *)cell forIndexPath:(NSIndexPath *)indexPath;

-(void)dropDownTableList:(DropDownTableList *)dropDownTableList didSelectedRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
@end



@interface DropDownTableList : UIView<UITableViewDataSource,UITableViewDelegate>
{   BOOL tableViewCellTouched;
    CGFloat UniversalX;
    CGFloat UniversalY;
    CGFloat UniversalWidth;
    CGFloat UniversalHeight;
    
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *DropDownViewLayer;
@property (nonatomic, strong) UIButton * Button;

-(instancetype)initDrawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
+(instancetype)drawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

@property(nonatomic,weak)id<DropDownTableListDelegate>delegate;
@property(nonatomic,weak)id<DropDownTableListDataSource>dataSource;

@end
