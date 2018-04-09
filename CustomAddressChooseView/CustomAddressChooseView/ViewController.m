//
//  ViewController.m
//  CustomAddressChooseView
//
//  Created by yjgx on 2018/4/9.
//  Copyright © 2018年 EL. All rights reserved.
//

#import "ViewController.h"
#import "LFAddressView.h"
#import "AddressModel.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addressTextTield;


@property (nonatomic,strong) AddressModel *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    LFAddressView *addressview = [[LFAddressView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200 ,self.view.bounds.size.width,200)];
    self.addressTextTield.inputView = addressview;
    
    [addressview showDefaultAddress:_model];
    
    addressview.finishSelect = ^(AddressModel *model) {
        
        weakSelf.model = model;
        
         weakSelf.addressTextTield.text = [NSString stringWithFormat:@"%@%@%@",model.provinceName,model.cityName,model.districtName];
       
        
    };
    [self.addressTextTield becomeFirstResponder];
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
     [self.addressTextTield resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
