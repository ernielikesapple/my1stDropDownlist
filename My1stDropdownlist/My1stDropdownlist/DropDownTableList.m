//
//  DropDownTableList.m
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/14/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import "DropDownTableList.h"

@interface DropDownTableList ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *DropDownViewLayer;

@property (nonatomic, strong) UIButton * Button;


@end



@implementation DropDownTableList


-(instancetype)initDrawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    self = [super initWithFrame:CGRectMake(x, y, width, height)];
    if(self){
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 20, 200, 0) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = UniversalColor(255,228,196);
        self.tableView.tag = 0;
//        self.tableView = self;
//        self.tableView = self;
       // self.DropDownViewLayer = [[UIView alloc] initWithFrame:CGRectMake(10, 10,10, 10)];
        [self addSubview:self.tableView];
        
        
 
    }
    return self;
}

+(instancetype)drawBottomFrame:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    return [[self alloc] initDrawBottomFrame:x y:y width:width height:height];
}




-(void)setDataSource:(id<DropDownTableListDataSource>)dataSource{
    
    //button layout related;
    self.Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.Button setImage:[UIImage imageNamed:@"arrowImageLeft"] forState:UIControlStateNormal];
    [self.Button setImage:[UIImage imageNamed:@"arrowImageLeft"] forState:UIControlStateHighlighted];
    [self.Button setImage:[UIImage imageNamed:@"arrowImageDown"] forState:UIControlStateSelected];
    [self.Button setImage:[UIImage imageNamed:@"arrowImageDown"] forState:UIControlStateSelected | UIControlStateHighlighted];
    
    [self.Button setTitle:@"Please Choose Your Info" forState:UIControlStateNormal];
    [self.Button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    //???????????
    // [self.Button setTitleEdgeInsets:UIEdgeInsetsMake(0, -(self.Button.imageView.bounds.size.width + 4), 0, self.Button.imageView.bounds.size.width + 4)];
    //   [self.Button setImageEdgeInsets:UIEdgeInsetsMake(0, self.Button.titleLabel.bounds.size.width, 0, -self.Button.titleLabel.bounds.size.width)];
    
    [self.Button setTag:0];
    
    
//    UIBezierPath* aPath = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20,200,40)];
//    aPath.lineWidth = 4.0;
//    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    //??/ self.Button.frame = [aPath stroke];
    
  
    self.Button.frame = CGRectMake(20,20, 200, 40);
    self.Button.clipsToBounds=YES;
    self.Button.layer.cornerRadius=10;
    
    
    self.Button.backgroundColor = UniversalColor(238,232,170);
     [self addSubview:self.Button];
    //  [self.Button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"33333333");
    
    
    
    //add gesture for tableView      //??????????????👇？？？？？？？？？
    UITapGestureRecognizer *tapForTablelist = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableViewClicked:)];
    //单指单击
    tapForTablelist.numberOfTapsRequired = 1;     //taps 次数    //这个参数可以配置单指双击    双指单机  双指双击  详见http://blog.sina.com.cn/s/blog_7c336a8301011b3e.html
    tapForTablelist.numberOfTouchesRequired = 1;  //taps手指数
   // tap.delegate =self;
    [self.tableView addGestureRecognizer:tapForTablelist];

    
    
    
    
    //从下往上滑动
    UISwipeGestureRecognizer *swipeDowntoUpForTablelist = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tableViewSwiped:)];
    //单指单击
     // tapForTablelist.numberOfTapsRequired = 1;     //http://www.jianshu.com/p/4ac617c9493b
    swipeDowntoUpForTablelist.numberOfTouchesRequired = 1;
    swipeDowntoUpForTablelist.direction = UISwipeGestureRecognizerDirectionUp;
    swipeDowntoUpForTablelist.delegate = self;
    [self.tableView addGestureRecognizer:swipeDowntoUpForTablelist];
   
    //从左往右滑动
    UISwipeGestureRecognizer *swipeLefttoRightForTablelist = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tableViewSwiped:)];
    //单指单击
    // tapForTablelist.numberOfTapsRequired = 1;     //http://www.jianshu.com/p/4ac617c9493b
    swipeLefttoRightForTablelist.numberOfTouchesRequired = 1;
    swipeLefttoRightForTablelist.direction = UISwipeGestureRecognizerDirectionRight;
    swipeLefttoRightForTablelist.delegate = self;
    [self.tableView addGestureRecognizer:swipeLefttoRightForTablelist];
    
    //从右往左滑动
    UISwipeGestureRecognizer *swipeRighttoLeftForTablelist = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tableViewSwiped:)];
    //单指单击
    // tapForTablelist.numberOfTapsRequired = 1;     //http://www.jianshu.com/p/4ac617c9493b
    swipeRighttoLeftForTablelist.numberOfTouchesRequired = 1;
    swipeRighttoLeftForTablelist.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeRighttoLeftForTablelist.delegate = self;
    [self.tableView addGestureRecognizer:swipeRighttoLeftForTablelist];
    
    
    
    //add gesture for button
    UITapGestureRecognizer *tapForButton = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClicked:)];
    //单指单击
    tapForButton.numberOfTapsRequired = 1;     //taps 次数
    tapForButton.numberOfTouchesRequired = 1;  //taps手指数
    tapForButton.delegate = self;
    [self.Button addGestureRecognizer:tapForButton];

//    [swipeUpForTablelist requireGestureRecognizerToFail:tapForButton];
//      [tapForButton requireGestureRecognizerToFail:swipeUpForTablelist];
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






//下拉菜单点击事件
-(void)tableViewClicked:( UITapGestureRecognizer  *)sender{

    if (self.tableView.tag == 1) {
    
        self.tableView.tag = 0;
        self.Button.tag = 0;
     
        [self stateTableClosedEvent];
    
    }
}

-(void)stateTableOpenEvent{
    //        self.Button.state = [UIButton ];
    
    [UIView animateWithDuration:(0.3) animations:^{
        //图片旋转
        // self.Button.imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        //                                   CGAffineTransformMakeRotation(M_PI_2);
        //self.Button.state =[UIControl UIControlStateSelected];
        
        CGRect frame = CGRectMake(20, self.Button.frame.size.height+25, 200,200);
        self.tableView.frame = frame;
        self.tableView.clipsToBounds=YES;
        self.tableView.layer.cornerRadius=10;
        
        
        self.Button.backgroundColor = UniversalColor(255,192,203);
        //[[self getCurrentWindowView] addSubview:self.tableView];
        NSLog(@"菜单打开!!!!!11111111");
    }];
    [UIView animateWithDuration:(3) animations:^{
        [self.Button setImage:[UIImage imageNamed:@"arrowImageDown"] forState:UIControlStateNormal];
    }];

}
-(void)stateTableClosedEvent{
    
    [UIView animateWithDuration:(0.3) animations:^{
        
        CGRect frame = CGRectMake(20, 20, 200, 0);
        self.tableView.frame = frame;
        
        
        self.Button.backgroundColor = UniversalColor(238,232,170);
        //[[self getCurrentWindowView] addSubview:self.tableView];
        NSLog(@"菜单关上!!!222222!");
    }];
    
    [UIView animateWithDuration:(3) animations:^{
        [self.Button setImage:[UIImage imageNamed:@"arrowImageLeft"] forState:UIControlStateNormal];
    }];

}

//下拉菜单滑动事件// UITapGestureRecognizer
-(void)tableViewSwiped:( UISwipeGestureRecognizer  *)sender{
  if (self.tableView.tag == 1) {
     //可以根据不同方向滑动设置不同事情
     if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
         self.tableView.tag = 0;
         self.Button.tag = 0;
    
    
        [UIView animateWithDuration:(0.3) animations:^{
        CGRect frame = CGRectMake(20, 20, 200, 0);
        self.tableView.frame = frame;
        self.tableView.backgroundColor = UniversalColor(255,228,196);

        self.Button.backgroundColor = UniversalColor(238,232,170);
            
        }];
       
        
        [UIView animateWithDuration:(3) animations:^{
            [self.Button setImage:[UIImage imageNamed:@"arrowImageLeft"] forState:UIControlStateNormal];
        }];
        
                //选择后重设button标题
//        [self.Button setTitle:@"Choose done!!!" forState:UIControlStateNormal];
//        [self.Button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        
        NSLog(@"菜单上选了事件并且关住!!!!!3333333333");
    
    
        //    }else{
//       
//        self.tableView.tag = 0;
//        
//        
//        [UIView animateWithDuration:(1) animations:^{
//            CGRect frame = CGRectMake(20, 20, 200, 20);
//            self.tableView.frame = frame;
//        self.tableView.backgroundColor = UniversalColor(255,250,250);
//         }];
//        NSLog(@"下面选择了事件!!!444444444!");
//    }
   
    } else if(sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        self.tableView.backgroundColor = UniversalColor(25,28,196);
       
        // self.tableView.tag = 0;
        //self.Button.tag = 0;

    
    }else if(sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        self.tableView.backgroundColor = UniversalColor(55,28,96);
        
        //self.tableView.tag = 0;
        //self.Button.tag = 0;
        
    }
      
      
      
  }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}



//-(UIView *)DropDownViewLayer{
//    if (self.DropDownViewLayer == nil) {
//        //?????
//        self.DropDownViewLayer = [[UIView alloc] initWithFrame:CGRectMake(10, 10,10, 10)];
//        NSLog(@"1!!!!");
//    }
//    else{
//        NSLog(@"2!!!!!!");
//    }
//    
//    return self.DropDownViewLayer;
//}




////???????????????????????????
//-(UIWindow *)getCurrentWindowView{
//
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    if(window.windowLevel != UIWindowLevelNormal){
//        
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for (UIWindow *tempWindow in windows) {
//            if(tempWindow.windowLevel == UIWindowLevelNormal){
//                window = tempWindow;
//                break;
//            }
//        }
//    }
//
//    return window;
//}

@end
