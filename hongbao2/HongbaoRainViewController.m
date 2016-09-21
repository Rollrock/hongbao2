//
//  HongbaoRainViewController.m
//  hongbao2
//
//  Created by 停有钱 on 16/9/9.
//  Copyright © 2016年 rock. All rights reserved.
//

#import "HongbaoRainViewController.h"
#import "HongBaoView.h"
#import "commonHead.h"

@import GoogleMobileAds;

#define SCREEN ([UIScreen mainScreen].bounds)//屏幕

#define COLUMN_NUM   4  //红包裂数
#define RAND_DELAY  1   //延时1秒
#define HONGBAO_WIDTH   60 //红包宽度
#define HONGBAO_HEIGHT  80 //红包高度

#define COLUMN_1_X   (SCREEN.size.width/COLUMN_NUM - HONGBAO_WIDTH )/2.0  //第1列红包X坐标
#define COLUMN_2_X   (SCREEN.size.width/COLUMN_NUM + (SCREEN.size.width/COLUMN_NUM - HONGBAO_WIDTH )/2.0)  //第2列红包X坐标
#define COLUMN_3_X   (SCREEN.size.width/COLUMN_NUM * 2 + (SCREEN.size.width/COLUMN_NUM - HONGBAO_WIDTH )/2.0)  //第3列红包X坐标
#define COLUMN_4_X   (SCREEN.size.width/COLUMN_NUM * 3 + (SCREEN.size.width/COLUMN_NUM - HONGBAO_WIDTH )/2.0)  //第3列红包X坐标


@interface HongbaoRainViewController ()<GADInterstitialDelegate>
{
    NSInteger hongbaoCount;
}

@property(strong,nonatomic) NSTimer * timer;
@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation HongbaoRainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"红包雨";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self timer];
    
    [self createAndLoadInterstitial];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createAndLoadInterstitial {
    
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3058205099381432/4747003541"];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
     
    [self.interstitial loadRequest:request];
}

-(void)genHongbao
{
    NSInteger colum = arc4random()%COLUMN_NUM;
    CGFloat xPos = 0;
    if( colum == 0 )
        xPos = COLUMN_1_X;
    else if( colum == 1 )
        xPos = COLUMN_2_X;
    else if( colum == 2 )
        xPos = COLUMN_3_X;
    else if( colum == 3 )
        xPos = COLUMN_4_X;
    
    HongBaoView * v = [[HongBaoView alloc]initWithFrame:CGRectMake(xPos, 0-HONGBAO_HEIGHT, HONGBAO_WIDTH, HONGBAO_HEIGHT)];
    [self.view addSubview:v];
    
    [UIView animateWithDuration:2 delay:0 options:(UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction) animations:^{
        
        [v setFrame:CGRectOffset(v.frame, 0, SCREEN.size.height - v.frame.origin.y )];
        
    } completion:^(BOOL finished) {
        
        [v removeFromSuperview];
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    for (UIView * v  in self.view.subviews)
    {
        if ([v isKindOfClass:[HongBaoView class] ]  && [v.layer.presentationLayer hitTest:touchLocation])
        {
            [v removeFromSuperview];
            
            hongbaoCount ++;
            
            return;
        }
    }
    
    //停止红包
    [self stopHongbao];
}

-(void)stopHongbao
{
    [self.timer invalidate];
    self.timer = nil;
    
    //显示谷歌插屏
    
    if (self.interstitial.isReady)
    {
        [self.interstitial presentFromRootViewController:self];
    }
    
    //延迟3秒之后显示结果
    [self setHongbaoMoney:hongbaoCount];
    //
    NSString * str = [NSString stringWithFormat:@"您本次一共抢了%.2f元红包",hongbaoCount/10.0];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"游戏结束" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * a1 = [UIAlertAction actionWithTitle:@"再来一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self timer];
    }];
    
    UIAlertAction * a2 = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * a3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [alert addAction:a1];
    [alert addAction:a3];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)setHongbaoMoney:(NSInteger)money
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSInteger c = [def integerForKey:HONGBAO_MONEY_STORE];
    
    [def setInteger:money+c forKey:HONGBAO_MONEY_STORE];
    [def synchronize];
}


#pragma setter & getter
-(NSTimer*)timer
{
    if( !_timer )
    {
        hongbaoCount = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(genHongbao) userInfo:nil repeats:YES];
    }
    
    return _timer;
}




@end
