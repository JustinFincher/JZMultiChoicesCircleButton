//
//  JZMultiChoicesCircleButton.m
//  JZMultiChoicesCircleButton
//
//  Created by Fincher Justin on 15/11/3.
//  Copyright © 2015年 Fincher Justin. All rights reserved.
//

#import "JZMultiChoicesCircleButton.h"
#import <QuartzCore/QuartzCore.h>

@interface UIView ()

@property (nonatomic) UIButton *SmallButton;
@property (nonatomic) UIView *BackgroundView;
@property (nonatomic) CGFloat SmallRadius;
@property (nonatomic) CGFloat BigRadius;
@property (nonatomic) CGPoint CenterPoint;
@property (nonatomic) UIImage* IconImage;
@property (nonatomic) CGFloat ParallexParameter;
@property (nonatomic) NSMutableArray* IconArray;
@property (nonatomic) NSMutableArray* InfoArray;
@property (nonatomic) NSMutableArray* ButtonTargetArray;
@property (nonatomic) BOOL isTouchDown;
@property (nonatomic) BOOL Parallex;
@property (nonatomic) BOOL isPerformingTouchUpInsideAnimation;
@property (nonatomic) CATextLayer* label;

@property (nonatomic) UIImageView *CallbackIcon;
@property (nonatomic) UILabel *CallbackMessage;

@property (nonatomic) CGFloat FullPara;
@property (nonatomic) NSNumber *MidiumPara;
@property (nonatomic) NSNumber *SmallPara;

@end


@implementation JZMultiChoicesCircleButton

@synthesize CircleColor,SmallRadius,BigRadius,CenterPoint,ParallexParameter;
@synthesize SmallButton,BackgroundView,IconImage,IconArray,label,InfoArray,ButtonTargetArray;
@synthesize isTouchDown,Parallex,isPerformingTouchUpInsideAnimation;
@synthesize CallbackMessage,CallbackIcon;
@synthesize FullPara,MidiumPara,SmallPara;
@synthesize ResponderUIVC;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

//Magic ....
-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id hitView = [super hitTest:point withEvent:event];
    if (hitView == self) return nil;
    else return hitView;
}

- (instancetype)initWithCenterPoint:(CGPoint)Point
                         ButtonIcon:(UIImage*)Icon
                        SmallRadius:(CGFloat)SRadius
                          BigRadius:(CGFloat)BRadius
                       ButtonNumber:(NSInteger)Number
                         ButtonIcon:(NSArray *)ImageArray
                         ButtonText:(NSArray *)TextArray
                       ButtonTarget:(NSArray *)TargetArray
                        UseParallex:(BOOL)isParallex
                  ParallaxParameter:(CGFloat)ParallexPara
              RespondViewController:(UIViewController *)VC
{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    
    self.SmallRadius = SRadius;
    self.BigRadius = BRadius;
    self.isTouchDown = NO;
    self.CenterPoint = Point;
    self.IconImage = Icon;
    self.ParallexParameter = ParallexPara;
    self.Parallex = isParallex;
    self.ResponderUIVC = VC;
    
    BackgroundView = [[UIView alloc] initWithFrame:CGRectMake(Point.x - SRadius,Point.y - SRadius, SRadius * 2, SRadius * 2)];
    BackgroundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    BackgroundView.layer.cornerRadius = SRadius;
    [self addSubview:BackgroundView];
    
    SmallButton = [[UIButton alloc] initWithFrame:CGRectMake(Point.x - SRadius,Point.y - SRadius, SRadius * 2, SRadius * 2)];
    SmallButton.layer.cornerRadius = SRadius;
    SmallButton.layer.backgroundColor = [[UIColor colorWithRed:252.0/255.0 green:81.0/255.0 blue:106.0/255.0 alpha:1.0]CGColor];
    SmallButton.layer.shadowColor = [[UIColor blackColor] CGColor];
    SmallButton.layer.shadowOffset = CGSizeMake(0.0, 6.0);
    SmallButton.layer.shadowOpacity = 0.3;
    SmallButton.layer.shadowRadius = 4.0;
    SmallButton.layer.zPosition = BRadius;
    
    [SmallButton setImage:IconImage forState:UIControlStateNormal];
    
    [SmallButton addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
    [SmallButton addTarget:self action:@selector(TouchDrag:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [SmallButton addTarget:self action:@selector(TouchDrag:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
    [SmallButton addTarget:self action:@selector(TouchUpInside:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [SmallButton addTarget:self action:@selector(TouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [self addSubview:SmallButton];
    
    ButtonTargetArray = [NSMutableArray arrayWithArray:TargetArray];
    InfoArray = [NSMutableArray arrayWithArray:TextArray];
    
    label = [[CATextLayer alloc] init];
    [label setFontSize:9.0f];
    [label setString:[NSString stringWithFormat:@"Choose:"]];
    label.fontSize = 40;
    label.font = (__bridge CFTypeRef)@"ArialMT";
    label.alignmentMode = kCAAlignmentCenter;
    [label setForegroundColor:[[UIColor colorWithWhite:1.0 alpha:0.0]CGColor]];
    [label setFrame:CGRectMake(-SmallRadius*3, -52, SmallRadius * 8,100)];
    
    
    CGFloat UnScaleFactor = SmallRadius/BigRadius;
    label.transform = CATransform3DMakeScale(UnScaleFactor, UnScaleFactor, 1.0f);
    [SmallButton.layer addSublayer:label];
    
    CGFloat TransformPara = BigRadius / SmallRadius;
    CGFloat MultiChoiceRadius = (BigRadius + SmallRadius)/8/TransformPara;
    IconArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < Number; i++)
    {
        
        CGFloat XOffest = 4 * MultiChoiceRadius * cos(2*M_PI*i/Number);
        CGFloat YOffest = 4 * MultiChoiceRadius * sin(2*M_PI*i/Number);
        
        
        UIImageView *IconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SRadius + XOffest - MultiChoiceRadius , SRadius + YOffest - MultiChoiceRadius, MultiChoiceRadius * 2, MultiChoiceRadius * 2)];
        if ([[ImageArray objectAtIndex:i] isKindOfClass:[UIImage class]])
        {
            IconImageView.image = [ImageArray objectAtIndex:i];
            IconImageView.alpha = 0.0f;
            [IconImageView setHidden:YES];
            [self.SmallButton addSubview:IconImageView];
            [self.SmallButton bringSubviewToFront:IconImageView];
            IconImageView.layer.contentsScale = [[UIScreen mainScreen] scale]*BigRadius/SmallRadius;
            [IconArray addObject:IconImageView];
        }
    }
    
    
    CGFloat UnFullFactor = SmallRadius/self.frame.size.height;
    CallbackIcon = [[UIImageView alloc] initWithFrame:CGRectMake((SmallButton.frame.size.width - BigRadius)/2, (SmallButton.frame.size.height - BigRadius)/2, BigRadius, BigRadius)];
    CallbackIcon.layer.transform = CATransform3DMakeScale(UnFullFactor, UnFullFactor, 1.0f);
    
    NSString *bundlePath = [[NSBundle bundleForClass:[JZMultiChoicesCircleButton class]]
                            pathForResource:@"JZMultiChoicesCircleButton" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    CallbackIcon.image = [UIImage imageNamed:@"CallbackSuccess" inBundle:bundle compatibleWithTraitCollection:nil];
    
    [CallbackIcon setAlpha:0.0f];
    [SmallButton addSubview:CallbackIcon];
    
    CallbackMessage = [[UILabel alloc] init];
    CallbackMessage.text = @"";
    CallbackMessage.alpha = 0.0f;
    CallbackMessage.font = [UIFont systemFontOfSize:20];
    CallbackMessage.layer.transform = CATransform3DMakeScale(UnFullFactor, UnFullFactor, 1.0f);
    CallbackMessage.textColor = [UIColor whiteColor];
    CallbackMessage.textAlignment = NSTextAlignmentCenter;
    [CallbackMessage setFrame:CGRectMake((SmallButton.frame.size.width - SmallRadius/2)/2, (SmallButton.frame.size.height - SmallRadius/4)/2+ 6, SmallRadius/2, SmallRadius/4)];
    [SmallButton addSubview: CallbackMessage];
    
    FullPara = self.frame.size.height/SmallRadius;
    MidiumPara = [SmallButton.layer valueForKeyPath:@"transform.scale"];
    SmallPara = [NSNumber numberWithFloat:1.0f];
    
    
    return self;
}


- (void)TouchDown
{
    if (self.isPerformingTouchUpInsideAnimation) {
        return;
    }
    //NSLog(@"TouchDown");
    if (!isTouchDown)
    {
        [self TouchDownAnimation];
        [label setForegroundColor:[[UIColor colorWithWhite:1.0 alpha:1.0]CGColor]];
    }
    self.isTouchDown = YES;
    
}

- (void)TouchDownAnimation
{
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){ [SmallButton.imageView setAlpha:0.0]; } completion:^(BOOL finished){ if (finished) { [SmallButton setImage:nil forState:UIControlStateNormal];}}];
    
    CABasicAnimation *ButtonScaleBigCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ButtonScaleBigCABasicAnimation.duration = 0.1f;
    ButtonScaleBigCABasicAnimation.autoreverses = NO;
    ButtonScaleBigCABasicAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    ButtonScaleBigCABasicAnimation.toValue = [NSNumber numberWithFloat:BigRadius / SmallRadius];
    ButtonScaleBigCABasicAnimation.fillMode = kCAFillModeForwards;
    ButtonScaleBigCABasicAnimation.removedOnCompletion = NO;
    
    [SmallButton.layer addAnimation:ButtonScaleBigCABasicAnimation forKey:@"ButtonScaleBigCABasicAnimation"];
    
    CABasicAnimation *BackgroundViewScaleBigCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    BackgroundViewScaleBigCABasicAnimation.duration = 0.1f;
    BackgroundViewScaleBigCABasicAnimation.autoreverses = NO;
    BackgroundViewScaleBigCABasicAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    BackgroundViewScaleBigCABasicAnimation.toValue = [NSNumber numberWithFloat:self.frame.size.height / SmallRadius];
    BackgroundViewScaleBigCABasicAnimation.fillMode = kCAFillModeForwards;
    BackgroundViewScaleBigCABasicAnimation.removedOnCompletion = NO;
    
    [BackgroundView.layer addAnimation:BackgroundViewScaleBigCABasicAnimation forKey:@"BackgroundViewScaleBigCABasicAnimation"];
    
    for (UIImageView *Icon in IconArray)
    {
        [self.layer removeAllAnimations];
        [Icon setHidden:NO];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){ Icon.alpha = 0.7f; } completion:^(BOOL finished){}];
    }
}
-(void)TouchDrag:(UIButton *)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint Point = [touch locationInView:self];
    //NSLog(@"TouchDrag:%@", NSStringFromCGPoint(Point));
    
    //UP: XOffest = MAX MakeRotation (xoffest,1,0,0)
    //RIGHT: YOffest = MAX MakeRotation (yoffest,0,1,0)
    CGFloat XOffest = Point.x - CenterPoint.x;
    CGFloat YOffest = Point.y - CenterPoint.y;
    //NSLog(@"XOffest %f    YOffest %f",XOffest,YOffest);
    
    CGFloat XDegress = XOffest / self.frame.size.width;
    CGFloat YDegress = YOffest / self.frame.size.height;
    //NSLog(@"XDegress %f    YDegress %f",XDegress,YDegress);
    
    CATransform3D Rotate = CATransform3DConcat(CATransform3DMakeRotation(XDegress, 0, 1, 0), CATransform3DMakeRotation(-YDegress, 1, 0, 0));
    if (Parallex)
    {
        SmallButton.layer.transform = CATransform3DPerspect(Rotate, CGPointMake(0, 0), BigRadius+ParallexParameter);
    }
    else
    {
        //Do nothing ^_^
    }
    
    NSUInteger count = 0;
    NSString *infotext;
    for (UIImageView *Icon in IconArray)
    {
        
        // Child center relative to parent
        CGPoint childPosition = [Icon.layer.presentationLayer position];
        
        // Parent center relative to UIView
        CGPoint parentPosition = [SmallButton.layer.presentationLayer position];
        CGPoint parentCenter = CGPointMake(SmallButton.bounds.size.width/2.0, SmallButton.bounds.size.height /2.0);
        
        // Child center relative to parent center
        CGPoint relativePos = CGPointMake(childPosition.x - parentCenter.x, childPosition.y - parentCenter.y);
        
        // Transformed child position based on parent's transform (rotations, scale etc)
        CGPoint transformedChildPos = CGPointApplyAffineTransform(relativePos, [SmallButton.layer.presentationLayer affineTransform]);
        
        // And finally...
        CGPoint positionInView = CGPointMake(parentPosition.x +transformedChildPos.x, parentPosition.y + transformedChildPos.y);
        
        //NSLog(@"positionInView %@",NSStringFromCGPoint(positionInView));
        
        //NSLog(@"View'S position %@",NSStringFromCGPoint(self.layer.position));
        
        CGFloat XOffest = (positionInView.x - self.CenterPoint.x)/SmallRadius*BigRadius;
        CGFloat YOffest = (positionInView.y - self.CenterPoint.y)/SmallRadius*BigRadius;
        
        CGRect IconCGRectinWorld = CGRectMake(self.CenterPoint.x + XOffest - (BigRadius + SmallRadius)/4, self.CenterPoint.y + YOffest - (BigRadius + SmallRadius)/4, (BigRadius + SmallRadius)/2, (BigRadius + SmallRadius)/2);
        
        //UIView *DEBUGVIEW = [[UIView alloc] initWithFrame:IconCGRectinWorld];
        //DEBUGVIEW.backgroundColor = [UIColor blackColor];
        //[self addSubview:DEBUGVIEW];
        
        if (CGRectContainsPoint(IconCGRectinWorld, Point))
        {
            //NSLog(@"Selected A button");
            [Icon setAlpha:1.0f];
            
            if ([[InfoArray objectAtIndex:count] isKindOfClass:[NSString class]])
            {
                //NSLog(@"INFO ");
                infotext = InfoArray[count];
            }
            
            
        }
        else
        {
            [Icon setAlpha:0.7f];
        }
        
        count++;
    }
    if (infotext)
    {
        [label setString:infotext];
    }
    else
    {
        [label setString:@"Choose:"];
    }
    
}


- (void)TouchUpInside:(UIButton *)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint Point = [touch locationInView:self];
    //NSLog(@"TouchUpInside:%@", NSStringFromCGPoint(Point));
    
    [label setForegroundColor:[[UIColor colorWithWhite:1.0 alpha:0.0]CGColor]];
    
    BOOL isTouchUpInsideButton = NO;
    int indexTouchUpInsideButton = 0;
    int count = 0;
    
    if (isTouchDown)
    {
        
        for (UIImageView *Icon in IconArray)
        {
            
            // Child center relative to parent
            CGPoint childPosition = [Icon.layer.presentationLayer position];
            
            // Parent center relative to UIView
            CGPoint parentPosition = [SmallButton.layer.presentationLayer position];
            CGPoint parentCenter = CGPointMake(SmallButton.bounds.size.width/2.0, SmallButton.bounds.size.height /2.0);
            
            // Child center relative to parent center
            CGPoint relativePos = CGPointMake(childPosition.x - parentCenter.x, childPosition.y - parentCenter.y);
            
            // Transformed child position based on parent's transform (rotations, scale etc)
            CGPoint transformedChildPos = CGPointApplyAffineTransform(relativePos, [SmallButton.layer.presentationLayer affineTransform]);
            
            // And finally...
            CGPoint positionInView = CGPointMake(parentPosition.x +transformedChildPos.x, parentPosition.y + transformedChildPos.y);
            
            //NSLog(@"positionInView %@",NSStringFromCGPoint(positionInView));
            
            //NSLog(@"View'S position %@",NSStringFromCGPoint(self.layer.position));
            
            CGFloat XOffest = (positionInView.x - self.CenterPoint.x)/SmallRadius*BigRadius;
            CGFloat YOffest = (positionInView.y - self.CenterPoint.y)/SmallRadius*BigRadius;
            
            CGRect IconCGRectinWorld = CGRectMake(self.CenterPoint.x + XOffest - (BigRadius + SmallRadius)/4, self.CenterPoint.y + YOffest - (BigRadius + SmallRadius)/4, (BigRadius + SmallRadius)/2, (BigRadius + SmallRadius)/2);
            
            //UIView *DEBUGVIEW = [[UIView alloc] initWithFrame:IconCGRectinWorld];
            //DEBUGVIEW.backgroundColor = [UIColor blackColor];
            //[self addSubview:DEBUGVIEW];
            if (CGRectContainsPoint(IconCGRectinWorld, Point))
            {
                isTouchUpInsideButton = YES;
                indexTouchUpInsideButton = count;
            }
            
            count++;
        }
        
        if (isTouchUpInsideButton)
        {
            [self TouchUpInsideAnimation];
            
            if ([ButtonTargetArray[indexTouchUpInsideButton] isKindOfClass:[NSString class]])
            {
                if (ResponderUIVC)
                {
                    SEL selector = NSSelectorFromString(ButtonTargetArray[indexTouchUpInsideButton]);
                    IMP imp = [ResponderUIVC methodForSelector:selector];
                    void (*func)(id, SEL) = (void *)imp;
                    func(ResponderUIVC, selector);
                }
            }
        }
        else
        {
            [self TouchUpAnimation];
        }
    }
    self.isTouchDown = NO;
    
}
- (void)TouchUpOutside
{
    //NSLog(@"TouchUpOutside");
    if (isTouchDown)
    {
        [self TouchUpAnimation];
        [label setForegroundColor:[[UIColor colorWithWhite:1.0 alpha:0.0]CGColor]];
    }
    self.isTouchDown = NO;
}

- (void)TouchUpInsideAnimation
{
    self.isPerformingTouchUpInsideAnimation = YES;

    for (UIImageView *Icon in IconArray)
    {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){ Icon.alpha = 0.0f; } completion:^(BOOL finished){if (finished) {[Icon setHidden:YES];}}];
    }
    
    CABasicAnimation *BackgroundViewScaleSmallCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    BackgroundViewScaleSmallCABasicAnimation.duration = 0.1f;
    BackgroundViewScaleSmallCABasicAnimation.autoreverses = NO;
    BackgroundViewScaleSmallCABasicAnimation.toValue = SmallPara;
    BackgroundViewScaleSmallCABasicAnimation.fromValue = MidiumPara;
    BackgroundViewScaleSmallCABasicAnimation.fillMode = kCAFillModeForwards;
    BackgroundViewScaleSmallCABasicAnimation.removedOnCompletion = NO;
    BackgroundViewScaleSmallCABasicAnimation.beginTime = 0.0f;
    [BackgroundView.layer addAnimation:BackgroundViewScaleSmallCABasicAnimation forKey:@"BackgroundViewScaleSmallCABasicAnimation"];
    
    CABasicAnimation *ButtonScaleFullCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ButtonScaleFullCABasicAnimation.duration = 0.2f;
    ButtonScaleFullCABasicAnimation.autoreverses = NO;
    ButtonScaleFullCABasicAnimation.toValue = @(FullPara);
    ButtonScaleFullCABasicAnimation.fromValue = MidiumPara;
    ButtonScaleFullCABasicAnimation.fillMode = kCAFillModeForwards;
    ButtonScaleFullCABasicAnimation.removedOnCompletion = NO;
    ButtonScaleFullCABasicAnimation.beginTime = 0.0f;
    
    //[SmallButton.layer addAnimation:ButtonScaleFullCABasicAnimation forKey:@"ButtonScaleAnimation"];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:ButtonScaleFullCABasicAnimation, nil];
    animGroup.duration = 0.4f;
    animGroup.removedOnCompletion = NO;
    animGroup.autoreverses = NO;
    animGroup.fillMode = kCAFillModeForwards;
    
    [CATransaction begin];
    __weak JZMultiChoicesCircleButton *weakSelf = self;
    [CATransaction setCompletionBlock:^
     {
         weakSelf.isPerformingTouchUpInsideAnimation = NO;
     }];
    [SmallButton.layer addAnimation:animGroup forKey:@"ButtonScaleAnimation"];
    [CATransaction commit];
    
    
    CATransform3D Rotate = CATransform3DConcat(CATransform3DMakeRotation(0, 0, 1, 0), CATransform3DMakeRotation(0, 1, 0, 0));
    if (Parallex)
    {
        SmallButton.layer.transform = CATransform3DPerspect(Rotate, CGPointMake(0, 0), BigRadius+ParallexParameter);
    }
    else
    {
        //Do nothing ^_^
    }
    
    
}

- (void)SuccessCallBackWithMessage:(NSString *)String
{
    NSString *bundlePath = [[NSBundle bundleForClass:[JZMultiChoicesCircleButton class]]
                            pathForResource:@"JZMultiChoicesCircleButton" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    CallbackIcon.image = [UIImage imageNamed:@"CallbackSuccess" inBundle:bundle compatibleWithTraitCollection:nil];
    CallbackMessage.text = String;
    [UIView animateWithDuration:0.3 animations:^(void){ CallbackMessage.alpha = 1.0; } completion:^(BOOL finished){}];
    [UIView animateWithDuration:0.3 animations:^(void){ [CallbackIcon setAlpha:1.0]; } completion:^(BOOL finished){}];
    
    CABasicAnimation *ButtonScaleKeepCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ButtonScaleKeepCABasicAnimation.duration = 2.0f;
    ButtonScaleKeepCABasicAnimation.autoreverses = NO;
    ButtonScaleKeepCABasicAnimation.fromValue = @(FullPara);
    ButtonScaleKeepCABasicAnimation.toValue = @(FullPara);
    ButtonScaleKeepCABasicAnimation.fillMode = kCAFillModeForwards;
    ButtonScaleKeepCABasicAnimation.removedOnCompletion = NO;
    ButtonScaleKeepCABasicAnimation.beginTime = 0.0f;
    
    CABasicAnimation *ButtonScaleSmallCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ButtonScaleSmallCABasicAnimation.duration = 0.2f;
    ButtonScaleSmallCABasicAnimation.autoreverses = NO;
    ButtonScaleSmallCABasicAnimation.fromValue = @(FullPara);
    ButtonScaleSmallCABasicAnimation.toValue = SmallPara;
    ButtonScaleSmallCABasicAnimation.fillMode = kCAFillModeForwards;
    ButtonScaleSmallCABasicAnimation.removedOnCompletion = NO;
    ButtonScaleSmallCABasicAnimation.beginTime = 2.0f;
    
    //[SmallButton.layer addAnimation:ButtonScaleSmallCABasicAnimation forKey:@"ButtonScaleAnimation"];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:ButtonScaleKeepCABasicAnimation,ButtonScaleSmallCABasicAnimation, nil];
    animGroup.duration = 2.2f;
    animGroup.removedOnCompletion = NO;
    animGroup.autoreverses = NO;
    animGroup.fillMode = kCAFillModeForwards;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^
     {
         [UIView animateWithDuration:0.1 animations:^(void){ [CallbackIcon setAlpha:0.0]; } completion:^(BOOL finished){}];
         [UIView animateWithDuration:0.1 animations:^(void){ CallbackMessage.alpha = 0.0;  } completion:^(BOOL finished){}];
         [SmallButton setImage:IconImage forState:UIControlStateNormal];
         [UIView animateWithDuration:0.1 animations:^(void){ [SmallButton.imageView setAlpha:1.0]; } completion:^(BOOL finished){}];
     }];
    [SmallButton.layer addAnimation:animGroup forKey:@"ButtonScaleAnimation"];
    [CATransaction commit];
    
}
- (void)FailedCallBackWithMessage:(NSString *)String
{
    NSString *bundlePath = [[NSBundle bundleForClass:[JZMultiChoicesCircleButton class]]
                            pathForResource:@"JZMultiChoicesCircleButton" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    CallbackIcon.image = [UIImage imageNamed:@"CallbackWrong" inBundle:bundle compatibleWithTraitCollection:nil];
    CallbackMessage.text = String;
    [UIView animateWithDuration:0.3 animations:^(void){ [CallbackMessage setAlpha:1.0]; } completion:^(BOOL finished){}];
    [UIView animateWithDuration:0.3 animations:^(void){ [CallbackIcon setAlpha:1.0]; } completion:^(BOOL finished){}];
    
    CABasicAnimation *ButtonScaleKeepCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ButtonScaleKeepCABasicAnimation.duration = 2.0f;
    ButtonScaleKeepCABasicAnimation.autoreverses = NO;
    ButtonScaleKeepCABasicAnimation.fromValue = @(FullPara);
    ButtonScaleKeepCABasicAnimation.toValue = @(FullPara);
    ButtonScaleKeepCABasicAnimation.fillMode = kCAFillModeForwards;
    ButtonScaleKeepCABasicAnimation.removedOnCompletion = NO;
    ButtonScaleKeepCABasicAnimation.beginTime = 0.0f;
    
    CABasicAnimation *ButtonScaleSmallCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ButtonScaleSmallCABasicAnimation.duration = 0.2f;
    ButtonScaleSmallCABasicAnimation.autoreverses = NO;
    ButtonScaleSmallCABasicAnimation.fromValue = @(FullPara);
    ButtonScaleSmallCABasicAnimation.toValue = SmallPara;
    ButtonScaleSmallCABasicAnimation.fillMode = kCAFillModeForwards;
    ButtonScaleSmallCABasicAnimation.removedOnCompletion = NO;
    ButtonScaleSmallCABasicAnimation.beginTime = 2.0f;
    
    //[SmallButton.layer addAnimation:ButtonScaleSmallCABasicAnimation forKey:@"ButtonScaleAnimation"];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:ButtonScaleKeepCABasicAnimation,ButtonScaleSmallCABasicAnimation, nil];
    animGroup.duration = 2.2f;
    animGroup.removedOnCompletion = NO;
    animGroup.autoreverses = NO;
    animGroup.fillMode = kCAFillModeForwards;
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^
     {
         [UIView animateWithDuration:0.1 animations:^(void){ [CallbackIcon setAlpha:0.0]; } completion:^(BOOL finished){}];
         [UIView animateWithDuration:0.1 animations:^(void){ [CallbackMessage setAlpha:0.0]; } completion:^(BOOL finished){}];
         [SmallButton setImage:IconImage forState:UIControlStateNormal];
         [UIView animateWithDuration:0.1 animations:^(void){ [SmallButton.imageView setAlpha:1.0]; } completion:^(BOOL finished){}];
     }];
    [SmallButton.layer addAnimation:animGroup forKey:@"ButtonScaleAnimation"];
    [CATransaction commit];
    
    
}

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}


- (void)TouchUpAnimation
{
    for (UIImageView *Icon in IconArray)
    {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){ Icon.alpha = 0.0f; } completion:^(BOOL finished){if (finished) {[Icon setHidden:YES];}}];
    }
    
    CABasicAnimation *ButtonScaleSmallCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    ButtonScaleSmallCABasicAnimation.duration = 0.2f;
    ButtonScaleSmallCABasicAnimation.autoreverses = NO;
    ButtonScaleSmallCABasicAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    ButtonScaleSmallCABasicAnimation.fromValue = [NSNumber numberWithFloat:BigRadius / SmallRadius];
    ButtonScaleSmallCABasicAnimation.fillMode = kCAFillModeForwards;
    ButtonScaleSmallCABasicAnimation.removedOnCompletion = NO;
    
    [SmallButton.layer addAnimation:ButtonScaleSmallCABasicAnimation forKey:@"ButtonScaleSmallCABasicAnimation"];
    
    CABasicAnimation *BackgroundViewScaleSmallCABasicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    BackgroundViewScaleSmallCABasicAnimation.duration = 0.1f;
    BackgroundViewScaleSmallCABasicAnimation.autoreverses = NO;
    BackgroundViewScaleSmallCABasicAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    BackgroundViewScaleSmallCABasicAnimation.fromValue = [NSNumber numberWithFloat:self.frame.size.height / SmallRadius];
    BackgroundViewScaleSmallCABasicAnimation.fillMode = kCAFillModeForwards;
    BackgroundViewScaleSmallCABasicAnimation.removedOnCompletion = NO;
    
    [BackgroundView.layer addAnimation:BackgroundViewScaleSmallCABasicAnimation forKey:@"BackgroundViewScaleSmallCABasicAnimation"];
    
    CATransform3D Rotate = CATransform3DConcat(CATransform3DMakeRotation(0, 0, 1, 0), CATransform3DMakeRotation(0, 1, 0, 0));
    if (Parallex)
    {
        SmallButton.layer.transform = CATransform3DPerspect(Rotate, CGPointMake(0, 0), BigRadius+ParallexParameter);
    }
    else
    {
        //Do nothing ^_^
    }
    
    
    [SmallButton setImage:IconImage forState:UIControlStateNormal];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){ [SmallButton.imageView setAlpha:1.0]; } completion:^(BOOL finished){}];
    
}
@end
