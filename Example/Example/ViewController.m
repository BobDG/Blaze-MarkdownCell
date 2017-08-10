//
//  ViewController.m
//  Example
//
//  Created by Bob de Graaf on 05-01-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BDGMacros.h"
#import "ViewController.h"
#import "BlazeMarkdownRow.h"
#import "BlazeMarkdownTableViewCell.h"

#define XIBMarkdownTableViewCell    @"MarkdownTableViewCell"

@interface ViewController ()
{
    
}

@property(nonatomic,strong) NSString *markdownString;

@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MarkdownSample" ofType:@"txt"];
    self.markdownString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self loadTableContent];
}

-(void)loadTableContent
{
    //Clear
    [self.tableArray removeAllObjects];
    
    //Section
    BlazeSection *section = [BlazeSection new];
    [self.tableArray addObject:section];
    
    //Row Label
    BlazeMarkdownRow *markdownRow = [BlazeMarkdownRow rowWithXibName:XIBMarkdownTableViewCell];
    markdownRow.markdownString = self.markdownString;
    markdownRow.markdownDefaultFont = [UIFont systemFontOfSize:16.0f];
    markdownRow.markdownTextColor = [UIColor grayColor];
    markdownRow.markdownLinksColor = UIColorFromRGB(0xf8a19a);
    markdownRow.markdownHeaderColor = [UIColor blackColor];
    [markdownRow setLinkTapped:^(NSURL *url) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }];
    [markdownRow setPhoneNumberTapped:^(NSString *phoneNumber) {
        [self showMessage:phoneNumber];
    }];
    [markdownRow setAddressTapped:^(NSDictionary *address) {
        [self showMessage:[NSString stringWithFormat:@"%@", address]];
    }];
    [section addRow:markdownRow];
    [markdownRow setConfigureCell:^(BlazeTableViewCell *aCell) {
        BlazeMarkdownTableViewCell *cell = (BlazeMarkdownTableViewCell *)aCell;
        cell.markdownLabel.linkAttributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
    }];
    
    //Reload
    [self.tableView reloadData];
}

-(void)showMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Do something" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];
    [self presentViewController:alertController animated:TRUE completion:nil];
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
}


@end










