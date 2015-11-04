//
//  JZMultiChoicesCircleButton.h
//  JZMultiChoicesCircleButton
//
//  Created by Fincher Justin on 15/11/3.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZMultiChoicesCircleButton : UIView

@property (nonatomic,strong) NSNumber *CircleRadius;
@property (nonatomic,strong) UIColor *CircleColor;
@property (nonatomic,strong) UIViewController *ResponderUIVC;

- (instancetype)initWithCenterPoint:(CGPoint)Point
                         ButtonIcon:(UIImage*)Icon
                        SmallRadius:(CGFloat)SRadius
                          BigRadius:(CGFloat)BRadius
                       ButtonNumber:(NSInteger)Number
                         ButtonIcon:(NSArray *)ImageArray
                         ButtonText:(NSArray *)TextArray
                       ButtonTarget:(NSArray *)TargetArray
                        UseParallex:(BOOL)isParallex
                  ParallaxParameter:(CGFloat)Parallex
              RespondViewController:(UIViewController *)VC;

- (void)SuccessCallBackWithMessage:(NSString *)String;
- (void)FailedCallBackWithMessage:(NSString *)String;


@end
