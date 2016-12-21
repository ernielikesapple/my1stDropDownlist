//
//  ViewController.m
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import "MainViewController.h"
#import "DropDownTableList.h"
#import "dataModelWithSelectedState.h"


@interface MainViewController ()<DropDownTableListDelegate,DropDownTableListDataSource>
@property (nonatomic,strong)DropDownTableList *dropDownList1;

@property(nonatomic,strong)NSArray *array;
//@property(nonatomic,strong)NSArray *optionsLabel;

@property(nonatomic,strong)NSMutableArray *arrayHoldingModel;



@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //dropDownList的数据来源  💣💣💣💣💣todo:用后台api请求到的responseObject.array替换
    self.array = @[@"A.when will you...",@"B.would you like..."];
    
    self.arrayHoldingModel = [[NSMutableArray alloc] init];
    for (NSUInteger i=0;i<self.array.count;i++){
          dataModelWithSelectedState *eachSingleDataModel = [[dataModelWithSelectedState alloc] init];
          [eachSingleDataModel setSelected:NO];
          [eachSingleDataModel setCellTitle:[self.array objectAtIndex:i]];
          [self.arrayHoldingModel addObject:eachSingleDataModel];
    }
    

    self.dropDownList1 = [DropDownTableList drawBottomFrame:30 y:200 width:300 height:60*self.array.count+60];
    self.dropDownList1.delegate = self;
    self.dropDownList1.dataSource = self;
    [self.view addSubview:self.dropDownList1];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma dropDownTableListWidget related
-(NSInteger)dropDownTableList:(DropDownTableList *)dropDownTableList numberOfRowsInSection:(NSInteger)section{
    if(dropDownTableList == _dropDownList1 ){
        return self.array.count;
    }else{
        return 0;
    }
}
-(dataModelWithSelectedState *)dropDownTableList:(DropDownTableList *)dropDownTableList setDropDownCellUsingModelAtIndexPath:(NSIndexPath *)indexPath{
    if(dropDownTableList == _dropDownList1 ){
    dataModelWithSelectedState *dataModel = [self.arrayHoldingModel objectAtIndex:indexPath.row];
    return dataModel;
    }else{
        dataModelWithSelectedState *NilModel = nil;
        return NilModel;
    }
}
-(void)dropDownTableList:(DropDownTableList *)dropDownTableList didSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    if(dropDownTableList == _dropDownList1 ){
        BOOL checkedValue = [[self.arrayHoldingModel objectAtIndex:indexPath.row] selected];
        BOOL newCheckedValue = checkedValue?NO:YES;
        [[self.arrayHoldingModel objectAtIndex:indexPath.row] setValue:(newCheckedValue?@"YES":@"NO") forKey:@"selected"] ;
}
    
}


@end
