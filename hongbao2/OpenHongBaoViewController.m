//
//  OpenHongBaoViewController.m
//  hongbao2
//
//  Created by 停有钱 on 16/9/9.
//  Copyright © 2016年 rock. All rights reserved.
//

#import "OpenHongBaoViewController.h"
#import "NSDate+Helper.h"

@import GoogleMobileAds;


@interface OpenHongBaoViewController ()<GADInterstitialDelegate>
{
    BOOL bFlag;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;

@property(nonatomic, strong) GADInterstitial *interstitial;

@property(strong,nonatomic) NSTimer * timer;

- (IBAction)openClicked;
- (IBAction)backClicked;

@end

@implementation OpenHongBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createAndLoadInterstitial];
    
    self.timeLab.text = @"";
    self.nameLab.text = self.titleStr;
    
    [self timer];
    
    self.bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OpenHongBaoBG"]];
}

- (void)createAndLoadInterstitial {
    
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3058205099381432/4747003541"];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    [self.interstitial loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openClicked {
    
    NSLog(@"openClicked");
    
    NSTimeInterval  now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval  t = [self.date timeIntervalSince1970];
    if(t - now <= 3 )//打开
    {
        if (self.interstitial.isReady  && !bFlag)
        {
            bFlag = YES;
            [self.interstitial presentFromRootViewController:self];
        }
    }
    
    
}

- (IBAction)backClicked {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateTimeLab
{
    NSTimeInterval  now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval  t = [self.date timeIntervalSince1970];
    if(t - now <= 0 )
    {
        self.timeLab.text = @"00:00:00";
        return;
    }
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:t-now];
    
    self.timeLab.text =[NSDate stringFromDate:date withFormat:@"HH:mm:ss"];
}

#pragma setter & getter
-(NSTimer*)timer
{
    if(!_timer )
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLab) userInfo:nil repeats:YES];
    }
    
    return _timer;
}
@end
