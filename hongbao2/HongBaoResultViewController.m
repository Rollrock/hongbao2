//
//  HongBaoResultViewController.m
//  hongbao2
//
//  Created by 停有钱 on 16/9/8.
//  Copyright © 2016年 rock. All rights reserved.
//

#import "HongBaoResultViewController.h"
#import "HongBaoResultTableViewCell2.h"
#import "HongBaoResultTableViewCell1.h"

// 名字   图片   钱数
#define HONGBAO_ARRAY  @[\
@{@"name":@"陈皮",@"img":@"image1",@"amount":@"1.3"},\
@{@"name":@"老九门",@"img":@"image2",@"amount":@"2"},\
@{@"name":@"知心爱人",@"img":@"image3",@"amount":@"0.4"},\
@{@"name":@"水灵灵",@"img":@"image4",@"amount":@"3"},\
@{@"name":@"爱情买卖",@"img":@"image5",@"amount":@"0.68"},\
@{@"name":@"ForEver",@"img":@"image6",@"amount":@"2.8"},\
@{@"name":@"小土豆",@"img":@"image7",@"amount":@"0.1"},\
@{@"name":@"等待戈多",@"img":@"image8",@"amount":@"0.2"},\
@{@"name":@"大卫强",@"img":@"image9",@"amount":@"0.5"},\
@{@"name":@"团长赵",@"img":@"image10",@"amount":@"1.2"},\
@{@"name":@"※堕落※",@"img":@"image11",@"amount":@"2.3"},\
@{@"name":@"朱晓业",@"img":@"image12",@"amount":@"2.8"},\
@{@"name":@"Alex",@"img":@"image13",@"amount":@"0.3"},\
@{@"name":@"抢红包",@"img":@"image14",@"amount":@"0.8"},\
@{@"name":@"Bean...",@"img":@"image15",@"amount":@"1"},\
@{@"name":@"Crazy",@"img":@"image16",@"amount":@"0.7"},\
@{@"name":@"小羊羊",@"img":@"image17",@"amount":@"0.4"},\
@{@"name":@"慧慧",@"img":@"image18",@"amount":@"3.1"},\
@{@"name":@"maomao",@"img":@"image19",@"amount":@"0.2"},\
@{@"name":@"茂茂",@"img":@"image20",@"amount":@"0.5"},\
@{@"name":@"David刘",@"img":@"image21",@"amount":@"0.7"},\
@{@"name":@"辛辛那提",@"img":@"image22",@"amount":@"0.65"},\
@{@"name":@"Rock",@"img":@"image23",@"amount":@"1.8"},\
@{@"name":@"August",@"img":@"image24",@"amount":@"0.2"},\
@{@"name":@"玄香",@"img":@"image25",@"amount":@"0.3"},\
@{@"name":@"小苹果",@"img":@"image26",@"amount":@"0.5"},\
@{@"name":@"情定西海",@"img":@"image27",@"amount":@"1.0"},\
@{@"name":@"情未了",@"img":@"image28",@"amount":@"1.8"},\
@{@"name":@"❤️琴",@"img":@"image29",@"amount":@"1.2"},\
@{@"name":@"金鱼",@"img":@"image30",@"amount":@"1.3"},\
@{@"name":@"玉石俱焚",@"img":@"image31",@"amount":@"2.0"},\
@{@"name":@"景天",@"img":@"image32",@"amount":@"2.7"},\
@{@"name":@"与飞鱼",@"img":@"image33",@"amount":@"0.9"},\
@{@"name":@"雨花石",@"img":@"image34",@"amount":@"0.7"},\
@{@"name":@"千亿田",@"img":@"image35",@"amount":@"1.4"},\
@{@"name":@"大肥仔",@"img":@"image36",@"amount":@"1.6"},\
@{@"name":@"吴高标",@"img":@"image37",@"amount":@"1.8"},\
@{@"name":@"向宝伟",@"img":@"image38",@"amount":@"0.1"},\
@{@"name":@"往事如烟",@"img":@"image39",@"amount":@"0.2"},\
@{@"name":@"织梦人",@"img":@"image40",@"amount":@"0.3"},\
@{@"name":@"AK47",@"img":@"image41",@"amount":@"0.6"},\
]


@interface HongBaoResultViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger bestIndex;
    CGFloat totalAmount;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic ) NSMutableArray * dataArray;
- (IBAction)backClicked;

@end

@implementation HongBaoResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray * array = [HONGBAO_ARRAY mutableCopy];
    
    CGFloat bestValue = 0;
    
    for( NSInteger i = 0; i < 15; ++ i )
    {
        NSInteger index = arc4random()%(15-i);
        
        NSDictionary * d = array[index];
        
        if( [d[@"amount"] floatValue] > bestValue )
        {
            bestIndex = i;
            bestValue = [d[@"amount"] floatValue];
        }
        
        totalAmount += [d[@"amount"] floatValue];
        
        [self.dataArray addObject:d];
        
        [array removeObjectAtIndex:index];
        
    }
    
    
    /*
    
    NSArray * tempArray = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
       
        CGFloat v1 = [((NSDictionary*)obj1)[@"amount"] floatValue];
        CGFloat v2 = [((NSDictionary*)obj2)[@"amount"] floatValue];
        
        return v1 < v2;
        
    }];
    
    self.dataArray = [tempArray copy];
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if( 0 == section )
        return 1;
    
    if( 1 == section )
        return 15;
    
    return 0;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 0 )
    {
        static NSString * cellId = @"HongBaoResultTableViewCell1";
        HongBaoResultTableViewCell1 * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if( !cell )
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil] lastObject];
        }
        
        [cell refreshCell:totalAmount];
        
        return cell;
    }
    else if( indexPath.section == 1 )
    {
        static NSString * cellId = @"HongBaoResultTableViewCell2";
        HongBaoResultTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if( !cell )
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil] lastObject];
        }
        
        [cell refreshCell:self.dataArray[indexPath.row] index:(indexPath.row != bestIndex)];
        
        
        return cell;
    }
    
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 0 )
        return 225;
    else if( indexPath.section == 1 )
        return 70;
    
    return 0;
}

#pragma setter & getter
-(NSMutableArray*)dataArray
{
    if( !_dataArray )
    {
        _dataArray = [NSMutableArray new];
    }
    
    return _dataArray;
}

- (IBAction)backClicked {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
