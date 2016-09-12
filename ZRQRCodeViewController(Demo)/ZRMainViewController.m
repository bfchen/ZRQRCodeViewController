//
//  ZRMainViewController.m
//  ZRQRCodeViewController
//
//  Created by VictorZhang on 9/12/16.
//  Copyright © 2016 XiaoRuiGeGe. All rights reserved.
//
//  https://github.com/VictorZhang2014/ZRQRCodeViewController
//  An open source library for iOS in Objective-C that is being compatible with iOS 7.0 and later.
//  Its main function that QR Code Scanning framework that are easier to call.
//

#import "ZRMainViewController.h"
#import "ZRQRCodeViewController.h"
#import "ZRAlertController.h"
#import "ZRQRCodeScanView.h"
#import "ZRGeneratedQRCodeViewController.h"
#import "ZRTmpViewController.h"

#define kHeader  @"kHeaderTitle"
#define kTag     @"kTag"
#define kBody    @"kBodyContent"

@interface ZRMainViewController()

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ZRMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:82.0 / 255.0 green:188.0 / 255.0 blue:248.0 / 255.0 alpha:1.0];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.navigationItem.title = @"QR Code";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.datas = @[
                   @[
                       @{
                           kHeader : @"1.These're methods of scan.",
                           kTag    : @1,
                           kBody   : @[
                                     @"Scanning QRCode of First Type",
                                     @"Scanning QRCode of Second Type"
                                     ]
                           }
                       ],
                   @[
                       @{
                           kHeader : @"2.The method of QRCode scanning by customing UIView",
                           kTag    : @2,
                           kBody   : @[
                                     @"Scanning QRCode by customing UIView"
                                     ]
                           }
                       ],
                   @[
                       @{
                           kHeader : @"3.The method of Recognized from The Photos' Library to select one picture first.",
                           kTag    : @3,
                           kBody   : @[
                                     @"Recognized from Photos to select one picture first"
                                     ]
                           }
                       ],
                   @[
                       @{
                           kHeader : @"4.The method of Recognized by long-presse from the indicated image.",
                           kTag    : @4,
                           kBody   : @[
                                     @"Recognized by long-press from the indicated image"
                                     ]
                           }
                       ],
                   @[
                       @{
                           kHeader : @"5.The method of Recognized from the indicated image.",
                           kTag    : @5,
                           kBody   : @[
                                     @"Recognized from the indicated image"
                                     ]
                           }
                       ],
                   @[
                       @{
                           kHeader : @"6.These're methods of generate QRCode and it returns UIImageView",
                           kTag    : @6,
                           kBody   : @[
                                     @"Generate QRCode through CGRect and data string",
                                     @"Generate QRCode through CGRect and data string with a center icon ",
                                     @"Generate QRCode through CGRect and data string with a center icon and UIImageView's shadow"
                                     ]
                           }
                       ]

                   ];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.datas objectAtIndex:section];
    NSDictionary *dic = [array firstObject];
    NSArray *array2 = dic[kBody];
    return array2.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *array = [self.datas objectAtIndex:section];
    NSDictionary *dic = [array firstObject];
    return dic[kHeader];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuse = @"cellReuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuse];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray *array = [self.datas objectAtIndex:indexPath.section];
    NSDictionary *dic = [array firstObject];
    NSArray *array2 = dic[kBody];
    cell.textLabel.text = [array2 objectAtIndex:indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *text = cell.textLabel.text;
    
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGFloat height = [text boundingRectWithSize:CGSizeMake(cell.frame.size.width, cell.frame.size.height) options:opts attributes:attributes context:nil].size.height;
    if (height <= 22.5) {
        height = 45;
    } else {
        height += 45;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSString *text = cell.textLabel.text;
    
    NSArray *array = [self.datas objectAtIndex:indexPath.section];
    NSDictionary *dic = [array firstObject];
    NSArray *array2 = dic[kBody];
    int tag = [dic[kTag] intValue];
    switch (tag) {
        case 1:
            if ([text isEqualToString:[array2 firstObject]]) {
                
                ZRQRCodeViewController *qrCode = [[ZRQRCodeViewController alloc] initWithScanType:ZRQRCodeScanTypeReturn];
                qrCode.qrCodeNavigationTitle = @"QR Code Scanning";
                qrCode.errorMessage = @"Access Denied";
                [qrCode QRCodeScanningWithViewController:self completion:^(NSString *strValue) {
                    NSLog(@"strValue = %@ ", strValue);
                    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strValue]]){
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strValue]];
                    } else {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:[NSString stringWithFormat:@"The result is %@", strValue] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                } failure:^(NSString *message) {
                    [[ZRAlertController defaultAlert] alertShowWithTitle:@"Note" message:message okayButton:@"Ok" completion:^{ }];
                    NSLog(@"Error Message = %@", message);
                }];
                
            } else {
            
                ZRQRCodeViewController *qrCode = [[ZRQRCodeViewController alloc] initWithScanType:ZRQRCodeScanTypeContinuation];
                [qrCode QRCodeScanningWithViewController:self completion:^(NSString *strValue) {
                    NSLog(@"strValue = %@ ", strValue);
                    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strValue]]){
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strValue]];
                    } else {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ooooops!" message:[NSString stringWithFormat:@"The result is %@", strValue] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                } failure:^(NSString *message) {
                    [[ZRAlertController defaultAlert] alertShowWithTitle:@"Note" message:message okayButton:@"Ok" completion:^{ }];
                    NSLog(@"Error Message = %@", message);
                }];
                
            }
            
            break;
        case 2:
            
             [[[ZRQRCodeScanView alloc] init] openQRCodeScan:self];
            
            break;
        case 3:
        {
            ZRQRCodeViewController *qrCode = [[ZRQRCodeViewController alloc] initWithScanType:ZRQRCodeScanTypeReturn];
            qrCode.textWhenNotRecognized = @"No any QR Code texture on the picture were found!";
            [qrCode recognizationByPhotoLibraryViewController:self completion:^(NSString *strValue) {
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
            break;
        case 4:
        {
            ZRTmpViewController *tmpVC = [[ZRTmpViewController alloc] init];
            tmpVC.type = 1;
            [self.navigationController pushViewController:tmpVC animated:YES];
        }
            
            break;
        case 5:
        {
        
            ZRTmpViewController *tmpVC = [[ZRTmpViewController alloc] init];
            tmpVC.type = 0;
            [self.navigationController pushViewController:tmpVC animated:YES];
            
        }
            
            break;
        case 6:
        {
            ZRGeneratedQRCodeViewController *generate = [[ZRGeneratedQRCodeViewController alloc] init];
            ZRQRCodeViewController *qrcode = [[ZRQRCodeViewController alloc] init];
            
            if ([text isEqualToString:[array2 firstObject]]) {
                CGRect rect = [UIScreen mainScreen].bounds;
                CGFloat w = rect.size.width;
                CGFloat h = w;
                CGFloat y = (rect.size.height - h) / 2;
                CGRect rect_target = CGRectMake(0, y, w, h);
                
                UIImageView *myImage = [qrcode generateQuickResponseCodeWithFrame:rect_target dataString:@"https://www.baidu.com"];
                
                generate.imageView = myImage;
            } else if ([text isEqualToString:[array2 lastObject]]) {
                
                CGRect rect = [UIScreen mainScreen].bounds;
                CGFloat w = rect.size.width;
                CGFloat h = w;
                CGFloat y = (rect.size.height - h) / 2;
                CGRect rect_target = CGRectMake(0, y, w, h);
                
                UIImage *center = [UIImage imageNamed:@"Victor.jpg"];
                UIImageView *myImage = [qrcode generateQuickResponseCodeWithFrame:rect_target dataString:@"https://www.baidu.com" centerImage:center needShadow:YES];
                
                generate.imageView = myImage;
                
            } else {
                
                CGRect rect = [UIScreen mainScreen].bounds;
                CGFloat w = rect.size.width;
                CGFloat h = w;
                CGFloat y = (rect.size.height - h) / 2;
                CGRect rect_target = CGRectMake(0, y, w, h);
                
                UIImage *center = [UIImage imageNamed:@"Victor.jpg"];
                UIImageView *myImage = [qrcode generateQuickResponseCodeWithFrame:rect_target dataString:@"https://www.baidu.com" centerImage:center];
                
                generate.imageView = myImage;
                
            }
            [self.navigationController pushViewController:generate animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
