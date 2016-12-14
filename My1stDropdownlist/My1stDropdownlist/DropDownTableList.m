//
//  DropDownTableList.m
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import "DropDownTableList.h"

@implementation DropDownTableList


-(instancetype)initDrawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    self = [super initWithFrame:CGRectMake(x, y, width, height)];
    
    return self;
}


+(instancetype)drawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    return [[self alloc] initDrawBottomFrame:x y:y width:width height:height];
}

@end
