//
//  MainViewController.m
//  hongbao2
//
//  Created by 停有钱 on 16/9/13.
//  Copyright © 2016年 rock. All rights reserved.
//

#import "MainViewController.h"
#import "HongBaoResultViewController.h"
#import "HongbaoRainViewController.h"
#import "DingshiViewController.h"
#import "OpenHongBaoViewController.h"
#import "IMBanner.h"
#import "IMBannerDelegate.h"
#import "IMInterstitial.h"
#import "IMInterstitialDelegate.h"
#import "IMNative.h"
#import "IMNativeDelegate.h"
#import "MyViewController.h"

@interface MainViewController ()<IMInterstitialDelegate>


@property(nonatomic,strong) IMInterstitial * interstitial;
@property(nonatomic,strong) NSTimer * advShowTimer;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"抢红包";
    
    //inmobi
    self.interstitial = [[IMInterstitial alloc] initWithPlacementId:1473609344470 delegate:self];
    [self.interstitial load];
    [self advShowTimer];
    
    self.navigationController.navigationBar.translucent = NO;
    
    UITapGestureRecognizer * g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hongbaoClicked:)];
    [[self.view viewWithTag:100] addGestureRecognizer:g];
    
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hongbaoClicked:)];
    [[self.view viewWithTag:101] addGestureRecognizer:g];
    
    g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hongbaoClicked:)];
    [[self.view viewWithTag:103] addGestureRecognizer:g];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)hongbaoClicked:(UITapGestureRecognizer*)g
{
    NSInteger tag = g.view.tag;
    
    if( tag == 100 )
    {
        HongbaoRainViewController * vc = [HongbaoRainViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if( tag == 101 )
    {
        DingshiViewController * vc = [DingshiViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if( tag == 103 )
    {
        MyViewController * vc = [MyViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)showInMobi
{
    if( self.interstitial.isReady )
    {
        [self.interstitial showFromViewController:self];
        [self.advShowTimer invalidate];
        self.advShowTimer = nil;
    }
}

-(NSTimer*)advShowTimer
{
    if( !_advShowTimer )
    {
        _advShowTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showInMobi) userInfo:nil repeats:YES];
    }
    return _advShowTimer;
}

@end
