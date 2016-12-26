//
//  NewsFeedViewController.m
//  RssReader
//
//  Created by AravindKumar on 12/25/16.
//  Copyright © 2016 DCI. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "RESideMenu.h"
#import "DetailViewController.h"
#import "CategoryAddingViewController.h"

@interface NewsFeedViewController ()
#define IsChannel 1
#define IsItem 0

    {
        NSMutableArray *feeds;
        NSMutableDictionary *item;
        NSMutableString *title;
        NSMutableString *link;
        NSString *element;
        
    }

@end

@implementation NewsFeedViewController

- (void)awakeFromNib
    {
        [super awakeFromNib];
    }
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mySpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    if (self.url.length == 0) {
        _url =@"http://images.apple.com/main/rss/hotnews/hotnews.rss";
    }
    [self getRequestFromRss];
}

-(void)getRequestFromRss
{
    
    NSMutableString *finalURLStr = [NSMutableString stringWithString: _url];
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
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receivedData];
    
    parser.delegate = self;
    self.channelFlag = -1;
    self.mutableData = [NSMutableString new];
    if (![parser parse]) {
    }
    NSLog(@"channel = %@", self.channel);
    
}
-(void)viewWillAppear:(BOOL)animated
    {
        self.navigationController.navigationBar.hidden = YES;
    }
- (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
       
    }
    
#pragma mark - Table View
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel * titleLbl = (UILabel *)[cell viewWithTag:2];
    UILabel * dateLbl = (UILabel *)[cell viewWithTag:3];
    titleLbl.text = [[_items objectAtIndex:indexPath.row] objectForKey: @"title"];
    NSString* date = [[_items objectAtIndex:indexPath.row] objectForKey: @"pubDate"];
    dateLbl.text = date;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *string = [[_items objectAtIndex:indexPath.row] objectForKey: @"link"];
    DetailViewController*detailWebViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailWebViewController.url = string;
    [self.navigationController pushViewController:detailWebViewController animated:YES];
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    [self.mySpinner startAnimating];
    [self.mutableData setString:@""];
    if ([elementName isEqualToString:@"channel"]) {
        self.channel = [NSMutableDictionary new];
        self.channelFlag = IsChannel;
    }
    if ([elementName isEqualToString:@"item"]) {
        self.item = [NSMutableDictionary new];
        if (!self.items) {
            self.items = [NSMutableArray new];
        }
        self.channelFlag = IsItem;
    }
    
    if ([elementName isEqualToString:@"atom:link"]) {
        self.channel[@"atomLink"] = attributeDict;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"title"]) {
        if (self.channelFlag == IsChannel) {
            self.channel[@"title"] = [self.mutableData copy];
        }
        if (self.channelFlag == IsItem) {
            self.item[@"title"] = [self.mutableData copy];
        }
    }
    if ([elementName isEqualToString:@"link"]) {
        if (self.channelFlag == IsChannel) {
            self.channel[@"link"] = [self.mutableData copy];
        }
        if (self.channelFlag == IsItem) {
            self.item[@"link"] = [self.mutableData copy];
        }
    }
    if ([elementName isEqualToString:@"description"]) {
        if (self.channelFlag == IsChannel) {
            self.channel[@"description"] = [self.mutableData copy];
        }
        if (self.channelFlag == IsItem) {
            self.item[@"description"] = [self.mutableData copy];
        }
    }
    if ([elementName isEqualToString:@"language"]) {
        self.channel[@"language"] = [self.mutableData copy];
    }
    if ([elementName isEqualToString:@"lastBuildDate"]) {
        self.channel[@"lastBuildDate"] = [self.mutableData copy];
    }
    if ([elementName isEqualToString:@"generator"]) {
        self.channel[@"generator"] = [self.mutableData copy];
    }
    if ([elementName isEqualToString:@"copyright"]) {
        self.channel[@"copyright"] = [self.mutableData copy];
    }
    if ([elementName isEqualToString:@"pubDate"]) {
        self.item[@"pubDate"] = [self.mutableData copy];
    }
    if ([elementName isEqualToString:@"guid"]) {
        self.item[@"guid"] = [self.mutableData copy];
    }
    if ([elementName isEqualToString:@"content:encoded"]) {
        self.item[@"contentEncoded"] = [self.mutableData copy];
    }
    if ([elementName isEqualToString:@"item"]) {
        [self.items addObject:self.item];
    }
    if ([elementName isEqualToString:@"channel"]) {
        self.channel[@"items"] = self.items;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [self.mutableData appendString:string];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    [self.mySpinner stopAnimating];
    
}
    
- (IBAction)sideMenuButtonSelected:(id)sender {
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)addCategorySelected:(id)sender {
    
    CategoryAddingViewController*detailWebViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoryAddingViewController"];
    
    [self.navigationController pushViewController:detailWebViewController animated:YES];
}
    @end
