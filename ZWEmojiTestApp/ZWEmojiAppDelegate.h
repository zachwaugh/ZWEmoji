//
//  ZWEmojiAppDelegate.h
//  ZWEmoji
//
//  Created by Zach Waugh on 8/31/12.
//  Copyright (c) 2012 Zach Waugh. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZWEmojiAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTextViewDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *tableView;

@end
