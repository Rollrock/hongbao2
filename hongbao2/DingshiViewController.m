//
//  DingshiViewController.m
//  hongbao2
//
//  Created by 停有钱 on 16/9/9.
//  Copyright © 2016年 rock. All rights reserved.
//

#import "DingshiViewController.h"
#import "NSDate+Helper.h"
#import "OpenHongBaoViewController.h"
#import "HongBaoResultViewController.h"


@interface DingshiViewController ()

@end

@implementation DingshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initViews];
    
    self.title = @"定时红包";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initViews
{
    NSDate * curTime = [NSDate date];
    
    for( UIView * v in self.view.subviews )
    {
        if( (v.tag >= 100) && (v.tag <= 110) )
        {
            NSString * timeStr = ((UILabel*)[v viewWithTag:10]).text;
            
            NSDateFormatter * f = [NSDateFormatter new];
            [f setDateFormat:@"yyyy-MM-dd"];
            NSString * s = [f stringFromDate:curTime];
            timeStr = [NSString stringWithFormat:@"%@ %@",s,timeStr];
            
            NSDate * date = [NSDate dateFromString:timeStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            if( [date compare:curTime] == NSOrderedDescending )
            {
                NSLog(@"红色");
                ((UILabel*)[v viewWithTag:11]).text = @"未开始";
                v.backgroundColor = [UIColor orangeColor];
                v.userInteractionEnabled = YES;
                
                UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hongbaoClicked:)];
                [v addGestureRecognizer:g];
            }
            else
            {
                ((UILabel*)[v viewWithTag:11]).text = @"已结束";
                v.backgroundColor = [UIColor lightGrayColor];
                v.userInteractionEnabled = YES;
                NSLog(@"灰色");
                
                UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showHongBaoResult)];
                [v addGestureRecognizer:g];
            }
        }
    }
}

-(void)showHongBaoResult
{
    HongBaoResultViewController * vc = [HongBaoResultViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)hongbaoClicked:(UITapGestureRecognizer*)g
{
    UIView * v = g.view;
    
    NSDate * curTime = [NSDate date];
    NSString * timeStr = ((UILabel*)[v viewWithTag:10]).text;
    NSString * nameStr = ((UILabel*)[v viewWithTag:9]).text;
    
    NSDateFormatter * f = [NSDateFormatter new];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSString * s = [f stringFromDate:curTime];
    timeStr = [NSString stringWithFormat:@"%@ %@",s,timeStr];
    
    NSDate * date = [NSDate dateFromString:timeStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    OpenHongBaoViewController * vc = [OpenHongBaoViewController new];
    vc.date = date;
    vc.titleStr = nameStr;
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
