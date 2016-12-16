//
//  DropDownTableList.h
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"


@protocol DropDownTableListDataSource <NSObject>

@optional

@end


@interface DropDownTableList : UIView
////<UITableViewDataSource,UITableViewDelegate>


-(instancetype)initDrawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
+(instancetype)drawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

@property(nonatomic,weak)id<DropDownTableListDataSource> dataSource;


@end
