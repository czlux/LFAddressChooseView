//
//  LFAddressView.h
//  CustomAddressChooseView
//
//  Created by yjgx on 2018/4/9.
//  Copyright © 2018年 EL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddressModel.h"
@interface LFAddressView : UIView

/**根据传进来的地址信息-切换到指定项*/
-(void)showDefaultAddress:(AddressModel*)model;

/**
 AddressModel 主要用来传值，实际应用中可以换成自己的模型
 */
@property (nonatomic,copy) void(^finishSelect)(AddressModel *model);

@end
