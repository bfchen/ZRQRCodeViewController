//
//  ZRTmpViewController.m
//  ZRQRCodeViewController
//
//  Created by Victor Zhang on 7/14/16.
//  Copyright © 2016 XiaoRuiGeGe. All rights reserved.
//

#import "ZRTmpViewController.h"
#import "ZRQRCodeViewController.h"
#import "ZRAlertController.h"

@interface ZRTmpViewController()

@property (nonatomic, strong) UIImageView *myImgView;

@end

@implementation ZRTmpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Long-press this picture";

    CGRect rect = self.view.frame;
    CGFloat x = 10;
    CGFloat w = rect.size.width - x * 2;
    CGFloat h = w + 80;
    CGFloat y = (rect.size.height - h) / 2;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [imgView setImage:[UIImage imageNamed:@"ZR_Victor0"]];
    [self.view addSubview:imgView];
    self.myImgView = imgView;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    if (self.type == 1) {
        [self RecognizedByLongPressFromTheIndicatedImage];
    } else {
        [self RecognizedFromTheIndicatedImage];
    }
}

- (void)RecognizedByLongPressFromTheIndicatedImage
{
    ZRQRCodeViewController *qrCode = [[ZRQRCodeViewController alloc] initWithScanType:ZRQRCodeScanTypeReturn];
    qrCode.cancelButton = @"Cancel";
    qrCode.actionSheets = @[];
    qrCode.extractQRCodeText = @"Extract QR Code";
    NSString *savedImageText = @"Save Image";
    qrCode.saveImaegText = savedImageText;
    [qrCode extractQRCodeByLongPressViewController:self Object:self.myImgView actionSheetCompletion:^(int index, NSString * _Nonnull value) {
        if ([value isEqualToString:savedImageText]) {
            [[ZRAlertController defaultAlert] alertShow:self title:@"" message:@"Saved Image Successfully!" okayButton:@"Ok" completion:^{ }];
        }
    } completion:^(NSString * _Nonnull strValue) {
        NSLog(@"strValue = %@ ", strValue);
        [[ZRAlertController defaultAlert] alertShow:self title:@"" message:[NSString stringWithFormat:@"Result: %@", strValue] okayButton:@"Ok" completion:^{
            if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strValue]]){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strValue]];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:[NSString stringWithFormat:@"The result is %@", strValue] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    } failure:^(NSString *message) {
        [[ZRAlertController defaultAlert] alertShowWithTitle:@"Note" message:message okayButton:@"Ok" completion:^{ }];
        NSLog(@"Error Message = %@", message);
    }];
}

- (void)RecognizedFromTheIndicatedImage
{
    NSString *result = [[[ZRQRCodeViewController alloc] init] canRecognize:self.myImgView.image];
    [[ZRAlertController defaultAlert] alertShow:self title:@"Result by the picture" message:result okayButton:@"Ok" completion:^{ }];
}

@end
