//
//  DropDownTableList.h
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilitySurfaceRelated.h"
#import "dataModelWithSelectedState.h"

@class DropDownTableList;
@protocol DropDownTableListDelegate <NSObject>

//💣💣💣💣💣💣💣💣💣为什么这句加到这里有问题？？？？？？？//答：不要轻易再.h中 轻易用setDelgegate,todo:搞清楚究竟什么是重写setDelegate
@optional
-(void)dropDownTableList:(DropDownTableList *)dropDownTableList didSelectedRowAtIndexPath:(NSIndexPath *)indexPath;
@end







@protocol DropDownTableListDataSource <NSObject>
//@required
@optional
-(NSInteger)dropDownTableList:(DropDownTableList *)dropDownTableList numberOfRowsInSection:(NSInteger)section;
//-(UITableViewCell *)dropDownTableList:(DropDownTableList *)dropDownTableList cellForRowAtIndexPath:(NSIndexPath *)indexPah;

//set up dropDownTableListCell method 1:
//expose user a more flexible Interface to set up the cell
-(UIView *)dropDownTableList:(DropDownTableList *)dropDownTableList contentViewForCell:(UIView *)cell forIndexPath:(NSIndexPath *)indexPath;


//set up dropDownTableListCell method 2:
//a much more simpler interface to set up the dropDownListCell
-(dataModelWithSelectedState *)dropDownTableList:(DropDownTableList *)dropDownTableList  setDropDownCellUsingModelAtIndexPath:(NSIndexPath *)indexPath;
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
