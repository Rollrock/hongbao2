//
//  HongBaoResultTableViewCell2.m
//  hongbao2
//
//  Created by 停有钱 on 16/9/8.
//  Copyright © 2016年 rock. All rights reserved.
//

#import "HongBaoResultTableViewCell2.h"
#import "NSDate+Helper.h"

@interface HongBaoResultTableViewCell2()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UILabel *bestLab;

@end


@implementation HongBaoResultTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshCell:(NSDictionary*)dict index:(NSInteger)index
{
    self.imgView.image = [UIImage imageNamed:dict[@"img"]];
    self.nameLab.text = dict[@"name"];
    self.amountLab.text = dict[@"amount"];
    
    self.bestLab.hidden = index;
    
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0-2];
    self.timeLab.text = [NSDate stringFromDate:date withFormat:@"HH:mm"];
}

@end
