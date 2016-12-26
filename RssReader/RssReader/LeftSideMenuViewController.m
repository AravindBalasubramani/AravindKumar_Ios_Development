//
//  LeftSideMenuViewController.m
//  Jil Jil
//
//  Created by AravindKumar on 12/25/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import "LeftSideMenuViewController.h"
#import "CategoryAddingViewController.h"
#import "NewsFeedViewController.h"
#import "SharedVariables.h"
#import "Coredata.h"
#import "FeedDetails.h"

@interface LeftSideMenuViewController ()
{
    UIAlertView *alert;
    NSMutableArray *feedDataArray;
}
@end

@implementation LeftSideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
     _categotyArray = [[NSMutableArray alloc] initWithObjects:@"Apple",@"shipster", @"Developer Apple", nil];
    _linkArray  = [[NSMutableArray alloc] initWithObjects:@"http://images.apple.com/main/rss/hotnews/hotnews.rss",@"http://nshipster.com/feed.xml",@"https://developer.apple.com/news/rss/news.rss", nil];

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isAdded"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isAdded"];
        
        for (int i=0; self.categotyArray.count>i; i++)
        {
            [[[SharedVariables sharedInstance] categoryMutableArray] addObject:self.categotyArray[i]];
            [[[SharedVariables sharedInstance] rssLinkMutableArray] addObject:self.linkArray[i]];
            [Coredata saveDetails:self.categotyArray[i] saveLink:self.linkArray[i]];
        }
           }
   }
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    feedDataArray = [Coredata fetchDetails];
    NSLog(@"%@",_categotyArray);
    NSLog(@"%@",_linkArray);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feedDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideMenuCell" forIndexPath:indexPath];
    FeedDetails* feed = [feedDataArray objectAtIndex:indexPath.row];
    NSLog(@"%@",feed.feedCategoryName);
    UILabel * categoryLbl = (UILabel *)[cell viewWithTag:10];
    categoryLbl.text = feed.feedCategoryName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            FeedDetails* feed = [feedDataArray objectAtIndex:indexPath.row];
            NSLog(@"%@",feed.feedRssLink);
            NewsFeedViewController*newsFeedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsFeedViewController"];
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:newsFeedViewController]animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            
            newsFeedViewController.url = feed.feedRssLink;
        });
    });
    
 }

- (IBAction)addCategorySelected:(id)sender {
    
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"CategoryAddingViewController"]]
                                                              animated:YES];
                 [self.sideMenuViewController hideMenuViewController];
 
}

- (IBAction)DelectSelected:(id)sender {
    
    UITableViewCell *cell = (UITableViewCell *)[sender superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"%@",indexPath);
    
            [Coredata deleteDetail:indexPath.row];
            [feedDataArray removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
}
@end
