//
//  dataModelWithSelectedState.h
//  My1stDropdownlist
//
//  Created by ernie.cheng on 12/21/16.
//  Copyright © 2016 ernie.cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataModelWithSelectedState : NSObject
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,strong)NSString *cellTitle;
//........ more fields from json api
@end
