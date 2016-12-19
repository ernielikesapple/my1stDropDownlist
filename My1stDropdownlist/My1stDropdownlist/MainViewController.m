//
//  ViewController.m
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import "MainViewController.h"
#import "DropDownTableList.h"
#import "exampleDataModel.h"


@interface MainViewController ()<DropDownTableListDelegate,DropDownTableListDataSource>
@property (nonatomic,strong)DropDownTableList *dropDownList1;

@property(nonatomic,strong)NSArray *array;

@property(nonatomic,strong)NSMutableArray *arrayHoldingModel;
@property(nonatomic,strong)NSMutableArray *ArrayHodlingCheckedState;


@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //dropDownList的数据来源  💣💣💣💣💣todo:用后台api请求到的responseObject.array替换
    self.array = @[@"1",@"2",@"3",@"4"];
    
    self.arrayHoldingModel = [[NSMutableArray alloc] init];
    self.ArrayHodlingCheckedState = [[NSMutableArray alloc] init];
    for (NSUInteger i=0;i<self.array.count;i++){
        exampleDataModel *eachSingleDataModel = [[exampleDataModel alloc] init];
        [eachSingleDataModel setSelected:NO];
        [eachSingleDataModel setCellTitle:[self.array objectAtIndex:i]];
        [self.arrayHoldingModel addObject:eachSingleDataModel];
       // NSLog(@"%@", arrayHoldingModel[i]);
    }
    
    
    
    //NSLog(@"executed~~~~~~~~3,%lu",(unsigned long)self.array.count);
    self.dropDownList1 = [DropDownTableList drawBottomFrame:30 y:200 width:300 height:60*self.array.count];
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
        [imageView setTag:0]; //0 means it's been toggled on
    }else{
        UIImage *image = [UIImage imageNamed:@"uncheckedIcon.png"];
        imageView = [[UIImageView alloc]initWithImage:[self makeImageScale:image scaledToSize:CGSizeMake(20,20)]];
        [imageView setTag:1]; //1 means it's been toggled off
    }
    return imageView;
}



#pragma dropDownTableListWidget related
-(NSInteger)dropDownTableList:(DropDownTableList *)dropDownTableList numberOfRowsInSection:(NSInteger)section{
    if(dropDownTableList == _dropDownList1 ){
    // NSLog(@"executed~~~~~~~~2,%lu",(unsigned long)self.array.count);
    return self.array.count;
//    return 5;
    }else{
    
        return 0;}
}

-(UIView*)dropDownTableList:(DropDownTableList *)dropDownTableList contentViewForCell:(UIView *)cell forIndexPath:(NSIndexPath *)indexPath{

 if(dropDownTableList == _dropDownList1 ){
 
     //init checkedArray bool value
     exampleDataModel *dataModel = [self.arrayHoldingModel objectAtIndex:indexPath.row];
     if([dataModel selected]){
         [self.ArrayHodlingCheckedState addObject:@"YES"];
     }else{
         [self.ArrayHodlingCheckedState addObject:@"NO"];
     }
     
     // NSLog(@"后执行");
    UIView *Thecell = [[UIView alloc] initWithFrame:cell.frame];
    [Thecell setTag:indexPath.row];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, cell.frame.origin.y+10, 20, 20)];
    BOOL checkedValue = [[self.ArrayHodlingCheckedState objectAtIndex:indexPath.row] boolValue];
    imageView = [self setImageBasedOnToggleState:checkedValue];
    [imageView setFrame:CGRectMake(10, cell.frame.origin.y+10, 10, 10)];
    [Thecell addSubview:imageView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, cell.frame.origin.y, 200, 30)];
    [label setFont:[UIFont fontWithName:@"Arial" size:14]];
    [label setText:self.array[indexPath.row]];
    [Thecell addSubview:label];
    
     
    return Thecell;
     
     
 }else{
     UIView *Nilcell = nil;
     return Nilcell;
 }
 
}

-(void)dropDownTableList:(DropDownTableList *)dropDownTableList didSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(dropDownTableList == _dropDownList1 ){
        
    NSLog(@"didSelected get called 222222");
    BOOL checkedValue = [[self.ArrayHodlingCheckedState objectAtIndex:indexPath.row] boolValue];
    BOOL newCheckedValue = checkedValue?NO:YES;
    [self.ArrayHodlingCheckedState replaceObjectAtIndex:indexPath.row withObject:(newCheckedValue?@"YES":@"NO")];
}
    
}


@end
