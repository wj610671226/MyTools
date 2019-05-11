//
//  WJPickerView.m
//  EasyFuture
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 麦 芽糖. All rights reserved.
//

#import "WJPickerView.h"


@interface WJPickerView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (nonatomic, copy) NSString * currentSelectedData;
@end

@implementation WJPickerView

+ (WJPickerView *)loadWJPickerViewWithXib {
    return [[NSBundle bundleForClass:self] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].lastObject;
}


- (IBAction)clickCancleButton:(UIButton *)sender {
    if (self.cancleBlcok) {
        self.cancleBlcok();
    }
}

- (IBAction)clickSureButton:(UIButton *)sender {
    if (self.sureBlcok) {
        self.currentSelectedData = self.currentSelectedData.length ? self.currentSelectedData : self.pickDataSources.firstObject;
        self.sureBlcok(self.currentSelectedData);
    }
}


#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currentSelectedData = self.pickDataSources[row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickDataSources.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickDataSources[row];
}
@end
