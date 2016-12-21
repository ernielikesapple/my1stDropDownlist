//
//  DropDownTableList.m
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import "DropDownTableList.h"
@interface DropDownTableList ()<UIGestureRecognizerDelegate>

//@property(nonatomic,strong)NSMutableArray *ArrayHodlingCheckedState;
@end
@implementation DropDownTableList
-(instancetype)initDrawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    self = [super initWithFrame:CGRectMake(x, y, width, height)];
    if(self){
        UniversalX = x;
        UniversalY = y;
        UniversalWidth = width;
        UniversalHeight = height;
    }
    [self drawTheWidgetBaseFrame];
    
   // self.ArrayHodlingCheckedState = [[NSMutableArray alloc] init];
    
    return self;
}
+(instancetype)drawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    return [[self alloc] initDrawBottomFrame:x y:y width:width height:height];
}
-(void)drawTheWidgetBaseFrame{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UniversalWidth, 0) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UniversalColor(255,228,196);
    self.tableView.tag = 0;
    tableViewCellTouched = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    self.Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.Button setTitle:@"Please Choose Your Info" forState:UIControlStateNormal];
    [self.Button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.Button setTag:0];
    self.Button.frame = CGRectMake(0,0,UniversalWidth, 40);
    self.Button.clipsToBounds=YES;
    self.Button.layer.cornerRadius=10;
    self.Button.backgroundColor = UniversalColor(238,232,170);
    [self addSubview:self.Button];
    
    //method1:?????????????
    UIEdgeInsets insets = UIEdgeInsetsMake(self.inputViewController.topLayoutGuide.length,
                                           0.0,
                                           self.inputViewController.bottomLayoutGuide.length,
                                           0.0);
    self.tableView.contentInset = insets;
    //method2:?????
    //self.inputViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    UITapGestureRecognizer *tapForButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClicked:)];
    tapForButton.numberOfTapsRequired = 1;
    tapForButton.numberOfTouchesRequired = 1;
    tapForButton.delegate = self;
    [self.Button addGestureRecognizer:tapForButton];
}
//按钮点击事件
-(void)buttonClicked:(UITapGestureRecognizer *)sender{
    if (self.Button.tag == 0) {
        //状态位
        self.Button.tag = 1;
        self.tableView.tag = 1;
        //触发事件
        [self stateTableOpenEvent];
    }else{
        self.Button.tag = 0;
        self.tableView.tag = 0;
        
        [self stateTableClosedEvent];
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{return YES;}
-(void)stateTableOpenEvent{
    [UIView animateWithDuration:(0.3) animations:^{
        CGRect frame = CGRectMake(0, self.Button.frame.size.height+5, UniversalWidth,UniversalHeight-self.Button.frame.size.height-5);
        self.tableView.frame = frame;
        self.tableView.clipsToBounds=YES;
        self.tableView.layer.cornerRadius=10;
        self.Button.backgroundColor = UniversalColor(255,192,203);
    }];
    [UIView animateWithDuration:(3) animations:^{
        [self.Button setImage:[UIImage imageNamed:@"arrowImageDown"] forState:UIControlStateNormal];
    }];
}
-(void)stateTableClosedEvent{
    [UIView animateWithDuration:(0.3) animations:^{
        CGRect frame = CGRectMake(0, 0, UniversalWidth, 0);
        self.tableView.frame = frame;
        self.Button.backgroundColor = UniversalColor(238,232,170);
    }];
    [UIView animateWithDuration:(3) animations:^{
        [self.Button setImage:[UIImage imageNamed:@"arrowImageLeft"] forState:UIControlStateNormal];
    }];
}
#pragma tableView related
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource dropDownTableList:self numberOfRowsInSection:0];
}
#pragma set Content in dropDownTableListWidget
-(UIImage *) makeImageScale:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContextWithOptions(newSize,NO, 0.0);//????????????????????
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(UIImageView *) setImageBasedOnToggleState:(BOOL)checked{
    UIImageView *imageView;
    if(checked){
        UIImage *image = [UIImage imageNamed:@"checkedIcon.png"];
        imageView = [[UIImageView alloc]initWithImage:[self makeImageScale:image scaledToSize:CGSizeMake(20,20)]];
    }else{
        UIImage *image = [UIImage imageNamed:@"uncheckedIcon.png"];
        imageView = [[UIImageView alloc]initWithImage:[self makeImageScale:image scaledToSize:CGSizeMake(20,20)]];
    }
    return imageView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellIdentifier = @"cellIdentifier";
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier]; //iOS 5 function
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    UIView *view = cell.contentView;//transfer the cell to this view variable to manage ,this is very important!
    for (UIView *views in [view subviews]) {
        [views removeFromSuperview];
    }
   
    dataModelWithSelectedState *model =  [self.dataSource dropDownTableList:self setDropDownCellUsingModelAtIndexPath:indexPath];
    BOOL boolValue = [model selected];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, view.frame.origin.y+10, 20, 20)];
    imageView = [self setImageBasedOnToggleState:boolValue];
    [imageView setFrame:CGRectMake(10, view.frame.origin.y+10, 10, 10)];
    [view addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, view.frame.origin.y, 200, 30)];
    [label setFont:[UIFont fontWithName:@"Arial" size:14]];
    [label setText:[model cellTitle]];
    [view addSubview:label];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate dropDownTableList:self didSelectedRowAtIndexPath:indexPath];
    NSArray *indexPaths = [[NSArray alloc]initWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:NO];
}
@end
