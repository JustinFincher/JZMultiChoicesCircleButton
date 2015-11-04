//
//  ViewController.m
//  JZMultiChoicesCircleButton
//
//  Created by Fincher Justin on 15/11/3.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import "ViewController.h"

#import "JZMultiChoicesCircleButton.h"

@interface ViewController ()


@property (nonatomic)JZMultiChoicesCircleButton *NewBTN ;
@end

@implementation ViewController
@synthesize NewBTN;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView * BGView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [BGView setImage:[UIImage imageNamed:@"BackGound"]];
    [self.view addSubview:BGView];
    
    
    NSArray *IconArray = [NSArray arrayWithObjects: [UIImage imageNamed:@"SendRound"],[UIImage imageNamed:@"CompleteRound"],[UIImage imageNamed:@"CalenderRound"],[UIImage imageNamed:@"MarkRound"],nil];
    NSArray *TextArray = [NSArray arrayWithObjects: [NSString stringWithFormat:@"Send"],[NSString stringWithFormat:@"Complete"],[NSString stringWithFormat:@"Calender"],[NSString stringWithFormat:@"Mark"], nil];
    NSArray *TargetArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"ButtonOne"],[NSString stringWithFormat:@"ButtonTwo"],[NSString stringWithFormat:@"ButtonThree"],[NSString stringWithFormat:@"ButtonFour"] ,nil];
    
    NewBTN = [[JZMultiChoicesCircleButton alloc] initWithCenterPoint:CGPointMake(self.view.frame.size.width / 2 , self.view.frame.size.height / 2 )
                                                                                      ButtonIcon:[UIImage imageNamed:@"send"]
                                                                                     SmallRadius:30.0f
                                                                                       BigRadius:120.0f
                                                                                    ButtonNumber:4
                                                                                      ButtonIcon:IconArray
                                                                                      ButtonText:TextArray
                                                                                    ButtonTarget:TargetArray
                                                                                     UseParallex:YES
                                                                               ParallaxParameter:300
                                                                           RespondViewController:self];
    [self.view addSubview:NewBTN];
    
    
    
}

- (void)ButtonOne
{
    NSLog(@"BUtton 1 Seleted");
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(SuccessLoadData) userInfo:nil repeats:NO];
}
- (void)ButtonTwo
{
    NSLog(@"BUtton 2 Seleted");
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(SuccessLoadData) userInfo:nil repeats:NO];
}
- (void)ButtonThree
{
    NSLog(@"BUtton 3 Seleted");
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(ErrorLoadData) userInfo:nil repeats:NO];
}
- (void)ButtonFour
{
    NSLog(@"BUtton 4 Seleted");
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ErrorLoadData) userInfo:nil repeats:NO];
}

- (void)SuccessLoadData
{
    [NewBTN SuccessCallBackWithMessage:@"YES!"];
}
- (void)ErrorLoadData
{
    [NewBTN FailedCallBackWithMessage:@"NO..."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
