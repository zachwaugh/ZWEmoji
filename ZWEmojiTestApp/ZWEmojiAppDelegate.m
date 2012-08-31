//
//  ZWEmojiAppDelegate.m
//  ZWEmoji
//
//  Created by Zach Waugh on 8/31/12.
//  Copyright (c) 2012 Zach Waugh. All rights reserved.
//

#import "ZWEmojiAppDelegate.h"
#import "ZWEmoji.h"

@interface ZWEmojiAppDelegate ()

@property (strong) NSArray *emojis;

@end

@implementation ZWEmojiAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSMutableArray *emojis = [NSMutableArray array];
	NSDictionary *codes = [ZWEmoji codes];
	
	[codes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[emojis addObject:@{@"code" : key, @"emoji" : obj}];
	}];
	
	[emojis sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj1[@"code"] compare:obj2[@"code"]];
	}];
	
	NSLog(@"total emoji: %ld", [emojis count]);
	
	self.emojis = emojis;
	
	[self.tableView reloadData];
}

#pragma mark - Table view delegate/data source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	return [self.emojis count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	NSDictionary *emoji = self.emojis[row];
	
	return emoji[tableColumn.identifier];
}

@end
