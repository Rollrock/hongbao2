//
//  HongBaoResultTableViewCell1.m
//  hongbao2
//
//  Created by 停有钱 on 16/9/9.
//  Copyright © 2016年 rock. All rights reserved.
//

#import "HongBaoResultTableViewCell1.h"

@interface HongBaoResultTableViewCell1()
@property (weak, nonatomic) IBOutlet UILabel *valueLab;


@end

@implementation HongBaoResultTableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCell:(CGFloat)value
{
    self.valueLab.text = [NSString stringWithFormat:@"%.2f元红包瞬间被抢完",value];
}

@end
