//
//  VCDemoTableVC.m
//  VCAntiScreenCapture_Example
//
//  Created by Vincent on 2018/12/31.
//  Copyright © 2018 mightyme@qq.com. All rights reserved.
//

#import "VTDemoTableVC.h"
#import "SimpleDRMVC.h"

@interface VTDemoTableVC ()

@end

@implementation VTDemoTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = nil;
    if (indexPath.row == 0) {
        vc = [storyBoard instantiateViewControllerWithIdentifier:@"SimpleDRMVC"];
    }
    else if (indexPath.row == 1) {
        vc = [storyBoard instantiateViewControllerWithIdentifier:@"EncodeVC"];
    }
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
