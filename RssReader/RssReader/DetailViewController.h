//
//  DetailViewController.h
//  RssReader
//
//  Created by AravindKumar on 12/25/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) NSString *url;
@property (weak, nonatomic) IBOutlet UIButton *backButtonOutlet;

- (IBAction)backButtonSelected:(id)sender;
@end
