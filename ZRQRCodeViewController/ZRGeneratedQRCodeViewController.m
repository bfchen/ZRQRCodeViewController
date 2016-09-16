//
//  ZRGeneratedQRCodeViewController.m
//  ZRQRCodeViewController
//
//  Created by VictorZhang on 9/12/16.
//  Copyright © 2016 XiaoRuiGeGe. All rights reserved.
//

#import "ZRGeneratedQRCodeViewController.h"

@implementation ZRGeneratedQRCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = self.imageView.frame;
    rect.origin.x = 10;
    rect.origin.y = (self.view.frame.size.height - rect.size.height) / 2;
    rect.size.width = rect.size.width - 20;
    self.imageView.frame = rect;
    [self.view addSubview:self.imageView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc
{
    
}

@end
