//
//  CategoryAddingViewController.m
//  RssReader
//
//  Created by AravindKumar on 12/25/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import "CategoryAddingViewController.h"

@interface CategoryAddingViewController ()


@end

@implementation CategoryAddingViewController
#define screenSize [[UIScreen mainScreen] bounds]

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _categoryNameTextField.delegate = self;
    _linkTextField.delegate = self;
    
    
    self.addCategoryView.hidden = YES;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveSelected:(id)sender {
    
    
    if (!self.categoryNameTextField.hasText) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Please enter Category name."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    else{
            [self getRequestFromRss];
    }
}

- (IBAction)backButtonSelected:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_categoryNameTextField resignFirstResponder];
    [_linkTextField resignFirstResponder];
    return YES;
}

-(void)getRequestFromRss
{
    
    NSMutableString *finalURLStr = [NSMutableString stringWithString: self.linkTextField.text];
    NSMutableURLRequest *request = nil;
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *receivedData = nil;
    request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString: finalURLStr]
                                      cachePolicy: NSURLRequestUseProtocolCachePolicy
                                  timeoutInterval: 60.0];
    receivedData = [NSURLConnection sendSynchronousRequest: request
                                         returningResponse: &response
                                                     error: &error];
    
    if (receivedData) {
        self.addCategoryView.hidden = NO;
        self.backgroundView = [[UIView alloc] initWithFrame:self.view.frame];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:29/255 green:185/255 blue:236/255 alpha:0.5];
        [self.view addSubview:self.backgroundView];
        self.addCategoryView= [[[NSBundle mainBundle]loadNibNamed:@"AddCategoryView" owner:self options:nil]objectAtIndex:0];
        self.addCategoryView.categoryAddingViewController = self;
        [self.addCategoryView setFrame:CGRectMake(100, -300, self.addCategoryView.frame.size.width, self.addCategoryView.frame.size.height)];
        self.addCategoryView.layer.cornerRadius = 30;
        [self.backgroundView addSubview:self.addCategoryView];
        [self.backgroundView bringSubviewToFront:self.addCategoryView];
        [self.addCategoryView setFrame:CGRectMake(screenSize.size.width/2 - self.addCategoryView.frame.size.width/2, -300, self.addCategoryView.frame.size.width, self.addCategoryView.frame.size.height)];
        [UIView animateWithDuration:0.10f animations:^{
            [self.addCategoryView setFrame:CGRectMake(screenSize.size.width/2 - self.addCategoryView.frame.size.width/2, 200, self.addCategoryView.frame.size.width, self.addCategoryView.frame.size.height)];
            
        }completion:^(BOOL finished) {
            
        }];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Please enter valid Rss link."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}
@end
