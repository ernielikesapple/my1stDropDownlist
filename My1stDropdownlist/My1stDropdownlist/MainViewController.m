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

//    for(int i = 0;i<26;i++){
//        
//        
//        unichar ch =65;
//        
//        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
//        [self.optionsLabel[i] addObject:str];
//        ch++;
//
//        NSLog(@"%@",self.optionsLabel[i]);
//    }
    
    self.arrayHoldingModel = [[NSMutableArray alloc] init];
   // self.ArrayHodlingCheckedState = [[NSMutableArray alloc] init];
    for (NSUInteger i=0;i<self.array.count;i++){
          dataModelWithSelectedState *eachSingleDataModel = [[dataModelWithSelectedState alloc] init];
          [eachSingleDataModel setSelected:NO];
          [eachSingleDataModel setCellTitle:[self.array objectAtIndex:i]];
        
          [self.arrayHoldingModel addObject:eachSingleDataModel];
    
    }
    
    
    
    
    
    
    
    //NSLog(@"executed~~~~~~~~3,%lu",(unsigned long)self.array.count);
    self.dropDownList1 = [DropDownTableList drawBottomFrame:30 y:200 width:300 height:500];
    //[self.dropDownList setCenter:CGPointMake(self.view.center.x, self.view.center.y)];
    //self.dropDownList.backgroundColor = UniversalColor(255,140,0);
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
        // NSLog(@"executed~~~~~~~~2,%lu",(unsigned long)self.array.count);
        return self.array.count;
        //    return 5;
    }else{
        return 0;
    }
}


/*
//控制dropdownlist 行数和每行显示的内容 最初方法版本0.01
----------------------------------------------------------------------------------------------------------------------------------------

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
        //[imageView setTag:0]; //0 means it's been toggled on
    }else{
        UIImage *image = [UIImage imageNamed:@"uncheckedIcon.png"];
        imageView = [[UIImageView alloc]initWithImage:[self makeImageScale:image scaledToSize:CGSizeMake(20,20)]];
        //[imageView setTag:1]; //1 means it's been toggled off
    }
    return imageView;
}


-(UIView*)dropDownTableList:(DropDownTableList *)dropDownTableList contentViewForCell:(UIView *)cell forIndexPath:(NSIndexPath *)indexPath{

 if(dropDownTableList == _dropDownList1 ){
 
     //init checkedArray bool value
     dataModelWithSelectedState *dataModel = [self.arrayHoldingModel objectAtIndex:indexPath.row];
     
     
     if([dataModel selected]){
         [self.ArrayHodlingCheckedState addObject:@"YES"];
     }else{
         [self.ArrayHodlingCheckedState addObject:@"NO"];
     }
     
     // NSLog(@"后执行");
    UIView *Thecell = [[UIView alloc] initWithFrame:cell.frame];
    [Thecell setTag:indexPath.row];

    BOOL checkedValue = [[self.ArrayHodlingCheckedState objectAtIndex:indexPath.row] boolValue];
     
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, cell.frame.origin.y+10, 20, 20)];
    imageView = [self setImageBasedOnToggleState:checkedValue];
    [imageView setFrame:CGRectMake(10, cell.frame.origin.y+10, 10, 10)];
    [Thecell addSubview:imageView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, cell.frame.origin.y, 200, 30)];
    [label setFont:[UIFont fontWithName:@"Arial" size:14]];
     
     [label setText:[dataModel cellTitle]];//self.array[indexPath.row]];
    [Thecell addSubview:label];
    
     
    return Thecell;
     
     
 }else{
     UIView *Nilcell = nil;
     return Nilcell;
 }
 
}

----------------------------------------------------------------------------------------------------------------------------------------

*/

//控制dropdownlist 行数和每行显示的内容 最初方法版本0.02
-(dataModelWithSelectedState *)dropDownTableList:(DropDownTableList *)dropDownTableList setDropDownCellUsingModelAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"----333 %ld",(long)indexPath.row);
    
    if(dropDownTableList == _dropDownList1 ){
    dataModelWithSelectedState *dataModel = [self.arrayHoldingModel objectAtIndex:indexPath.row];
    return dataModel;
    
    }else{
        dataModelWithSelectedState *NilModel = nil;
        return NilModel;
    }
}
-(void)dropDownTableList:(DropDownTableList *)dropDownTableList didSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"----4444 %ld",(long)indexPath.row);
    if(dropDownTableList == _dropDownList1 ){
        
        BOOL checkedValue = [[self.arrayHoldingModel objectAtIndex:indexPath.row] selected];
        BOOL newCheckedValue = checkedValue?NO:YES;
    
        [[self.arrayHoldingModel objectAtIndex:indexPath.row] setValue:(newCheckedValue?@"YES":@"NO") forKey:@"selected"] ;
   
//        //[temp setValue:@"aa" forKey:@""];
//        NSString *temp =[[self.arrayHoldingModel objectAtIndex:indexPath.row] valueForKey:@"selected"];
//        NSLog(@"-----%@",temp);
}
    
}


@end
