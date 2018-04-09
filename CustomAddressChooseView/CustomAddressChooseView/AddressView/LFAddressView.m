//
//  LFAddressView.m
//  CustomAddressChooseView
//
//  Created by yjgx on 2018/4/9.
//  Copyright © 2018年 EL. All rights reserved.
//

#import "LFAddressView.h"
#import "AddressJSONModel.h"
#import <YYModel.h>
@interface LFAddressView()<UIPickerViewDelegate,UIPickerViewDataSource>

/**全部数据模型 -通过YYModel 转换过来*/
@property (nonatomic,strong) NSArray<AddressJSONModel*> *dataArray;


@property (nonatomic,strong) UIPickerView *dataPicker;
/**省份序列*/
@property (nonatomic,assign) NSInteger provinceIndex;
/**省下级对应的市 index*/
@property (nonatomic,assign) NSInteger cityIndex;
/**区 县*/
@property (nonatomic,assign) NSInteger districtIndex;

@end

@implementation LFAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self loadData];
        
        _provinceIndex = 0;
        _cityIndex     = 0;
        _districtIndex = 0;
        
        [self subviewsInit];
    }
    return self;
}

-(void)subviewsInit{
    
    _dataPicker = [[UIPickerView alloc] init];
    _dataPicker.frame = self.bounds;
    [self addSubview:_dataPicker];
    
    _dataPicker.delegate = self;
    _dataPicker.dataSource = self;
    
    
    
}

-(void)loadData{
    
    // 从MainBundle中加载文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"areas" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray  *jsonArray = [NSJSONSerialization
                           JSONObjectWithData:data options:NSJSONReadingAllowFragments
                           error:nil];
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (NSDictionary *obj in jsonArray) {
        
        AddressJSONModel *model = [AddressJSONModel yy_modelWithJSON:obj];
        
        [tempArr addObject:model];
    }
    
    _dataArray = tempArr;
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    switch (component) {
        case 0:
            return _dataArray.count;//省份个数
            break;
        case 1:
        {
            return _dataArray[_provinceIndex].s.count;
        }
            break;
        case 2:
        {
            return _dataArray[_provinceIndex].s[_cityIndex].s.count;
        }
            break;
            
        default:
            return 0;
            break;
    }
    
    
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
            
            return _dataArray[row].n;
            break;
        case 1:
        {
            
            return _dataArray[_provinceIndex].s[row].n;
        }
            break;
        case 2:
        {
            
            return _dataArray[_provinceIndex].s[_cityIndex].s[row].n;
        }
            break;
        default:
            break;
    }
    
    return  @"";
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
        {
            
            _provinceIndex = row;
            _cityIndex = 0;
            _districtIndex = 0;
            
            [_dataPicker selectRow:0 inComponent:1 animated:false];
            [_dataPicker selectRow:0 inComponent:2 animated:false];
            
            [_dataPicker reloadComponent:1];
            [_dataPicker reloadComponent:2];
        }
            break;
        case 1:
        {
            
            _cityIndex = row;
            _districtIndex = 0;
            
            [_dataPicker selectRow:0 inComponent:2 animated:false];
            [_dataPicker reloadComponent:2];
        }
            break;
        case 2:
        {
            _districtIndex = row;
            [pickerView reloadAllComponents];
        }
            break;
            
        default:
            break;
    }
    
    AddressModel *model = [[AddressModel alloc] init];
    
    model.provinceName = self.dataArray[_provinceIndex].n;
    model.provinceID   = self.dataArray[_provinceIndex].i;
    
    model.cityName = self.dataArray[_provinceIndex].s[_cityIndex].n;
    model.cityID   = self.dataArray[_provinceIndex].s[_cityIndex].i;
    
    model.districtName = self.dataArray[_provinceIndex].s[_cityIndex].s[_districtIndex].n;
    model.districtID   = self.dataArray[_provinceIndex].s[_cityIndex].s[_districtIndex].i;
    
    if (self.finishSelect) {
        
        self.finishSelect(model);
    }
    NSLog(@"province:-%@ city- %@,county:-%@",self.dataArray[_provinceIndex].n,self.dataArray[_provinceIndex].s[_cityIndex].n,self.dataArray[_provinceIndex].s[_cityIndex].s[_districtIndex].n);
    
    
}

- (void)showDefaultAddress:(AddressModel*)model{
    
    if (model == nil) {
        
        return;
    }
    
    NSString *provinceid = model.provinceID;
    NSString *cityid = model.cityID;
    NSString *districtid = model.districtID;
    
    __weak typeof(self) weakSelf = self;
  
    /**查找省 下标*/
    [self.dataArray enumerateObjectsUsingBlock:^(AddressJSONModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.i isEqualToString:provinceid]) {
            
            weakSelf.provinceIndex = idx;
            
            
        }
    }];
    
    /**查找市 下标*/
    
    NSArray *cityModel = self.dataArray[_provinceIndex].s;
    
    [cityModel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        AddressJSONModel *inmodel = (AddressJSONModel*)obj;
        if ([inmodel.i isEqualToString:cityid]) {
            
            weakSelf.cityIndex = idx;
        }
        
    }];
    
    /**查找区县 下标*/
    
    AddressJSONModel *disModel = cityModel[_cityIndex];
    
    [disModel.s enumerateObjectsUsingBlock:^(AddressJSONModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.i isEqualToString:districtid]) {
            
            weakSelf.districtIndex = idx;
        }
    }];
    
    [_dataPicker selectRow:_provinceIndex inComponent:0 animated:false];
    [_dataPicker selectRow:_cityIndex inComponent:1 animated:false];
    [_dataPicker selectRow:_districtIndex inComponent:2 animated:false];
    
    [_dataPicker reloadAllComponents];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
