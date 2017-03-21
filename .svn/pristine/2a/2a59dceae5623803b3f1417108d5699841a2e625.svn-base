//
//  PositionSubscriberListTableViewCell.m
//  dww
//
//  Created by Shadow. G on 2017/1/3.
//  Copyright © 2017年 haoxitech. All rights reserved.
//

#import "PositionSubscriberListTableViewCell.h"

@implementation PositionSubscriberListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickEditButtonAction:(id)sender {
    if (self.didClickEditButtonBlock) {
        self.didClickEditButtonBlock();
    }
}

- (IBAction)clickDeleteButtonAction:(id)sender {
    if (self.didClickDeleteButtonBlcok) {
        self.didClickDeleteButtonBlcok();
    }
}

- (void)configCellWithData:(NSDictionary *)data
{
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        self.jobPositionNameLabel.text = NSValueToString(data[@"subclassLocal"]);
        NSString * wageBegin=  NSValueToString(data[@"wageBegin"]);
        NSString * wageEnd = NSValueToString(data[@"wageEnd"]);
        
        if (wageBegin.length > 0 && wageEnd.length > 0 ) {
            self.wageLabel.text = [NSString stringWithFormat:@"%@-%@元/月", wageBegin,wageEnd];
        }
        else if (wageBegin.length>0&&wageEnd.length==0)
        {
            self.wageLabel.text = [NSString stringWithFormat:@"%@元/月", wageBegin];
        }else if (wageBegin.length==0&&wageEnd.length>0)
        {
            self.wageLabel.text = [NSString stringWithFormat:@"%@元/月", wageEnd];

        }else{
        
            self.wageLabel.text = nil;
        }
        NSMutableArray * dataArray = [NSMutableArray array];
        
        NSString * topclass = NSValueToString(data[@"topclassLocal"]);
        NSString * sdistrictLocal = NSValueToString(data[@"sdistrictLocal"]);
        NSString * companyLoacal = NSValueToString(data[@"companyTypeLocal"]);
        NSString * salry = NSValueToString(data[@"scaleLocal"]);
        
        
        if (topclass.length > 0) {
            [dataArray addObject:topclass];
        }
        if (sdistrictLocal.length > 0) {
            [dataArray addObject:sdistrictLocal];
        }
        if (companyLoacal.length > 0) {
            [dataArray addObject:companyLoacal];
        }
        if (salry.length > 0) {
            [dataArray addObject:salry];
        }
        self.extraInfoLabel.text = [dataArray componentsJoinedByString:@" | "];
        
//        if (self.extraInfoLabel.text.length > 0) {
//            self.extraInfoLabel.text = [NSString stringWithFormat:@"%@ |%@", self.extraInfoLabel.text, NSValueToString(data[@"districtLocal"])];
//        } else
//        {
//            self.extraInfoLabel.text = NSValueToString(data[@"districtLocal"]);
//        }
//        if (self.extraInfoLabel.text.length > 0) {
//            self.extraInfoLabel.text = [NSString stringWithFormat:@"%@ |%@", self.extraInfoLabel.text, NSValueToString(data[@"companyTypeLocal"])];
//        } else
//        {
//            self.extraInfoLabel.text = NSValueToString(data[@"companyTypeLocal"]);
//        }
//        if (self.extraInfoLabel.text.length > 0) {
//            self.extraInfoLabel.text = [NSString stringWithFormat:@"%@ |%@", self.extraInfoLabel.text, NSValueToString(data[@"scaleLocal"])];
//        } else
//        {
//            self.extraInfoLabel.text = NSValueToString(data[@"scaleLocal"]);
//        }

    }
}

@end
