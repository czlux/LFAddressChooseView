//
//  AddressJSONModel.h
//  CustomAddressChooseView
//
//  Created by yjgx on 2018/4/9.
//  Copyright © 2018年 EL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressJSONModel : NSObject
/**地址对应的编号*/
@property (nonatomic,copy) NSString *i;
/**地址对应的名字*/
@property (nonatomic,copy) NSString *n;
/**模型嵌套*/
@property (nonatomic,strong) NSArray<AddressJSONModel *> *s;

@end
