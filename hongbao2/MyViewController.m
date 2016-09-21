//
//  MyViewController.m
//  hongbao2
//
//  Created by 停有钱 on 16/9/14.
//  Copyright © 2016年 rock. All rights reserved.
//

#import "MyViewController.h"
#import "commonHead.h"

@interface MyViewController ()

@property (weak, nonatomic) IBOutlet UILabel *hongbaoLab;

- (IBAction)drawClicked;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSInteger c = [def integerForKey:HONGBAO_MONEY_STORE];
    
    self.hongbaoLab.text = [NSString stringWithFormat:@"%.1f元",c/10.0];
    
    self.title = @"我的红包";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawClicked {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的余额还未达到最低提取金额，如要强行提现请先我们好评！" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ping-guo-shou-ji-zhu-shou/id1062736226?l=zh&ls=1&mt=8"]];
        
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"钱不要了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
