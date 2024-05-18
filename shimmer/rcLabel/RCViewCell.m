//
//  RCViewCell.m
//  RCLabel
//
//  Created by Hang Chen on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RCViewCell.h"


@implementation RCViewCell

@synthesize rtLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        RCLabel *label = [[RCLabel alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
		self.rtLabel = label;
        [label release];
		[self.contentView addSubview:self.rtLabel];
		[self.rtLabel setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	CGSize optimumSize = [self.rtLabel optimumSize];
	CGRect frame = [self.rtLabel frame];
	frame.size.height = (int)optimumSize.height + 5;    
	[self.rtLabel setFrame:frame];
    
}

- (void)dealloc {
	self.rtLabel = nil;
    [super dealloc];
}


@end

