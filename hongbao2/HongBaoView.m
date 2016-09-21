//
//  HongBaoView.m
//  hongbao2
//
//  Created by 停有钱 on 16/9/9.
//  Copyright © 2016年 rock. All rights reserved.
//

#import "HongBaoView.h"

@interface HongBaoView()
{
    
}

@property(strong,nonatomic) UIButton * btn;

@end

@implementation HongBaoView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self.btn setFrame:CGRectOffset(frame, 0-frame.origin.x, 0-frame.origin.y)];
    [self addSubview:self.btn];
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    
    return self;
}


-(UIButton*)btn
{
    if( !_btn )
    {
        _btn = [[UIButton alloc]initWithFrame:CGRectZero];
        
        [_btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchDown];
        [_btn setBackgroundImage:[UIImage imageNamed:@"hongbao"] forState:UIControlStateNormal];
    }
    
    return _btn;
}


-(void)btnClicked
{
    [self removeFromSuperview];
}



@end
