//
//  AddCategoryView.m
//  RssReader
//
//  Created by AravindKumar on 12/25/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import "AddCategoryView.h"
#import "CategoryAddingViewController.h"
#import "LeftSideMenuViewController.h"
#import "Coredata.h"

@implementation AddCategoryView
#define screenSize [[UIScreen mainScreen] bounds]
{
    
}

- (IBAction)cancelSelected:(id)sender {
    
    [UIView animateWithDuration:0.10f animations:^{
        [self setFrame:CGRectMake(screenSize.size.width/2 - self.frame.size.width/2, -300, self.frame.size.width, self.frame.size.height)];
    }completion:^(BOOL finished) {
        [self.categoryAddingViewController.backgroundView removeFromSuperview];
        
    }];
}
- (IBAction)saveSelected:(id)sender {
    
    [[[SharedVariables sharedInstance] rssLinkMutableArray] addObject:self.categoryAddingViewController.linkTextField.text];
    [[[SharedVariables sharedInstance] categoryMutableArray] addObject:self.categoryAddingViewController.categoryNameTextField.text];
    [Coredata saveDetails:self.categoryAddingViewController.categoryNameTextField.text saveLink:self.categoryAddingViewController.linkTextField.text];
 
    [UIView animateWithDuration:0.10f animations:^{
         [self setFrame:CGRectMake(screenSize.size.width/2 - self.frame.size.width/2, screenSize.size.height, self.frame.size.width, self.frame.size.height)];
    }completion:^(BOOL finished) {
         [self.categoryAddingViewController.backgroundView removeFromSuperview];
        [self.categoryAddingViewController.navigationController popViewControllerAnimated:YES];
        
    }];
}
@end
