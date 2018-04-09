//
//  AddressModel.h
//  CustomAddressChooseView
//
//  Created by yjgx on 2018/4/9.
//  Copyright © 2018年 EL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
/**省一级 名字和编号*/
@property (nonatomic,copy) NSString *provinceName;
@property (nonatomic,copy) NSString *provinceID;
/**市一级 名字和编号*/
@property (nonatomic,copy) NSString *cityName;
@property (nonatomic,copy) NSString *cityID;
/**区县一级 名字和编号*/
@property (nonatomic,copy) NSString *districtName;
@property (nonatomic,copy) NSString *districtID;

@end
