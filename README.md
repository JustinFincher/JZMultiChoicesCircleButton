# JZMultiChoicesCircleButton
![JZ.jpg](https://github.com/JustinFincher/JZMultiChoicesCircleButton/raw/master/DemoPic/JZ.jpg)  

[![CI Status](http://img.shields.io/travis/Fincher Justin/JZMultiChoicesCircleButton.svg?style=flat)](https://travis-ci.org/Fincher Justin/JZMultiChoicesCircleButton)
[![Version](https://img.shields.io/cocoapods/v/JZMultiChoicesCircleButton.svg?style=flat)](http://cocoapods.org/pods/JZMultiChoicesCircleButton)
[![License](https://img.shields.io/cocoapods/l/JZMultiChoicesCircleButton.svg?style=flat)](http://cocoapods.org/pods/JZMultiChoicesCircleButton)
[![Platform](https://img.shields.io/cocoapods/p/JZMultiChoicesCircleButton.svg?style=flat)](http://cocoapods.org/pods/JZMultiChoicesCircleButton)

#Introduction
JZMultiChoicesCircleButton is a Multi-choices button.  
Just tap it and hold to your choice! yeah ,so cool, such easy.   
It's inspired by Nicola Felasquez Felaco's [work](https://dribbble.com/shots/2293573-Pubbblish)  
And This is my [implementation](https://dribbble.com/shots/2333536-ParallaxCircleButton) using ObjC, demo gif:   
![DemoGiF.gif](https://github.com/JustinFincher/JZMultiChoicesCircleButton/raw/master/DemoPic/DemoGiF.gif) 

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```
#import "JZMultiChoicesCircleButton.h"

- (void)viewDidLoad {
    [super viewDidLoad];

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

```
**ButtonIcon**: UIImage,the icon in the small button  
**SmallRadius and BigRadius**: CGFloat, Small button radius and the size when it's animated  
**ButtonNumber**: int, how many buttons  
**ButtonIcon**: NSArray of UIImage   
**ButtonText**: NSArray of NSString  
**ButtonTarget** : NSArray of NSString,just String of selector and JZMultiChoicesCircleButton will use NSSelectorFromString to transform it to SEL  
**UseParallex** : BOOL, if YES will be 3D-like, or just 2D with no Parallex effect.  
**ParallaxParameter**: CGFloat,bigger than 0, the smaller the cooler Parallex effect will be  
**RespondViewController**: should be UIViewcontroller,the responder, simply 'self' will be ok.  

```
- (void)SuccessLoadData
{
    [NewBTN SuccessCallBackWithMessage:@"YES!"];
}
- (void)ErrorLoadData
{
    [NewBTN FailedCallBackWithMessage:@"NO..."];
}
```
Use SuccessCallBackWithMessage and FailedCallBackWithMessage to show the animated infomation , or button will be **full screen and don't disappear!!!!**



## Installation

JZMultiChoicesCircleButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JZMultiChoicesCircleButton"
```

Or just grab JZMultiChoicesCircleButton.h and .m from github,   
Edit  
```
[UIImage imageNamed:@"CallbackSuccess" inBundle:bundle compatibleWithTraitCollection:nil];
```  
With  
```
[UIImage imageNamed:@"CallbackSuccess"];
```    
and grab CallbackSuccess.png and CallbackWrong.png.


##TO-DO 

1.Rewrite using scale down animation to prevent the blur CATextlayer

## Author

Fincher Justin, zhtsu47@me.com

## License

JZMultiChoicesCircleButton is available under the MIT license. See the LICENSE file for more info.
