//
//  AddressJSONModel.m
//  CustomAddressChooseView
//
//  Created by yjgx on 2018/4/9.
//  Copyright © 2018年 EL. All rights reserved.
//

#import "AddressJSONModel.h"
#import <YYModel.h>
@implementation AddressJSONModel

+(NSDictionary *)modelContainerPropertyGenericClass{
    
    return @{@"s":[AddressJSONModel class]
             
             };
}


@end
