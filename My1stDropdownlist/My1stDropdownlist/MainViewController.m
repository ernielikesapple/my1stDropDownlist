//
//  ViewController.m
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import "MainViewController.h"
#import "DropDownTableList.h"

@interface MainViewController ()<DropDownTableListDelegate,DropDownTableListDataSource,UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong)DropDownTableList *dropDownList;

@property(nonatomic,strong)NSArray *array;

@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.array = @[@1,@2,@3,@4];
    NSLog(@"executed~~~~~~~~3,%lu",(unsigned long)self.array.count);
    self.dropDownList = [DropDownTableList drawBottomFrame:30 y:30 width:300 height:400];
    self.dropDownList.backgroundColor = UniversalColor(255,140,0);
    self.dropDownList.delegate = self;
    self.dropDownList.dataSource = self;
    [self.view addSubview:self.dropDownList];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)dropDownTableList:(DropDownTableList *)dropDownTableList numberOfRowsInSection:(NSInteger)section{
    NSLog(@"executed~~~~~~~~2,%lu",(unsigned long)self.array.count);
    return self.array.count;
}

-(UIView*)dropDownTableList:(DropDownTableList *)dropDownTableList contentViewForCell:(UIView *)cell forText:(NSString *)text forIndexPath:(NSIndexPath *)indexPath{
    
    UIView *view = [[UIView alloc] initWithFrame:cell.frame];
    [view setTag:indexPath.row];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, cell.frame.origin.y+10, 20, 20)];
    //BOOL checkedValue = [[checkedArray objectAtIndex:indexPath.row] boolValue];
    //imageView = [self imageViewForChecked:checkedValue];
    [imageView setFrame:CGRectMake(10, cell.frame.origin.y+10, 10, 10)];
    [imageView setImage: [UIImage imageNamed:@"checkedIcon.png"]];
    
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, cell.frame.origin.y, 200, 30)];
    [label setFont:[UIFont fontWithName:@"Arial" size:14]];
    [label setText:text];
    [view addSubview:label];
    
    return view;
}

@end
