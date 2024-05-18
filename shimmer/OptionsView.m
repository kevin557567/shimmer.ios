//
//  PlayViewController.m
//  zengzi
//
//  Created by 振标 曹 on 13-2-28.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "OptionsView.h"
#import "./rcLabel/RCViewCell.h"

@implementation OptionsViewController
@synthesize dataArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

//- (void)viewDidUnload
//{
//    [super viewDidUnload];
    // Release any retained subviews of the main view.
//}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"MODULE_ABOUT", nil);
        UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [homebtn setFrame:CGRectMake(0, 2, 32, 32)];
        [homebtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
        [homebtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:homebtn];
        [self.navigationItem setLeftBarButtonItem:btnItem];
		self.dataArray = [NSMutableArray array];
        
        //读取HTML
        NSMutableDictionary *row = [NSMutableDictionary dictionary];
        NSString *optui = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]  pathForResource:NSLocalizedString(@"ABOUT_VIEW",nil) ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
        [row setObject:optui forKey:@"text"];
		[self.dataArray addObject:row];
    }
    return self;
}

- (void)back{
    //[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSMutableDictionary *rowInfo = [self.dataArray objectAtIndex:indexPath.row];
	if ([rowInfo objectForKey:@"cell_height"]){
		return [[rowInfo objectForKey:@"cell_height"] floatValue];
	}else {
        RCLabel *tempLabel = [[RCLabel alloc] initWithFrame:CGRectMake(10,0,300,100)];
        //tempLabel.lineBreakMode = kCTLineBreakByTruncatingTail;
        RTLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:[rowInfo objectForKey:@"text"]];
        tempLabel.componentsAndPlainText = componentsDS;
        CGSize optimalSize = [tempLabel optimumSize];
       // [tempLabel release];
        [rowInfo setObject:[NSNumber numberWithFloat:optimalSize.height + 5] forKey:@"cell_height"];
		return [[rowInfo objectForKey:@"cell_height"] floatValue];
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    return [self.dataArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DemoTableViewCell";
    NSMutableDictionary *rowInfo = [self.dataArray objectAtIndex:indexPath.row];
    RCViewCell *cell = (RCViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[RCViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    RTLabelComponentsStructure *componentsDS = [RCLabel extractTextStyle:[rowInfo objectForKey:@"text"]];
    cell.rtLabel.componentsAndPlainText = componentsDS;   
    return cell;
}

#pragma mark -
#pragma mark Memory management
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
	self.dataArray = nil;
}
@end
