//
//  ViewController.m
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import "MainViewController.h"
#import "DropDownTableList.h"

@interface MainViewController ()<DropDownTableListDataSource>
@property (nonatomic,strong)DropDownTableList *dropDownList;



@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dropDownList = [DropDownTableList drawBottomFrame:30 y:30 width:300 height:400];
    self.dropDownList.backgroundColor = UniversalColor(	255,140,0);
    self.dropDownList.dataSource =self;
    [self.view addSubview:self.dropDownList];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
