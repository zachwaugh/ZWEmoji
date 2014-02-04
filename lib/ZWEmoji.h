//
//  ZWEmoji.h
//  ZWEmoji
//
//  Created by Zach Waugh on 8/31/12.
//  Copyright (c) 2012 Zach Waugh. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const ZWEmojiStringKey;
extern NSString * const ZWEmojiReplacedEmojiKey;

@interface ZWEmoji : NSObject

// Dictionary keyed by :<code>:
+ (NSDictionary *)codes;

// Dictionary keyed by unicode emoji character
+ (NSDictionary *)emojis;

// Return unicode character for emoji :<code>:
+ (NSString *)emojiForCode:(NSString *)code;

// Return :<code>: for emoji unicode character
+ (NSString *)codeForEmoji:(NSString *)emoji;

// Replace codes with emoji unicode characters
+ (NSString *)emojify:(NSString *)string;

// Returns a dictionary that holds a string and array of emojis that were replaced
// useful if you need the ranges of all the replacements
+ (NSDictionary *)emojifyAndReturnData:(NSString *)string;

// Replace emoji unicode characters with codes, allows users to input emoji directly
// without having to worry about the code
+ (NSString *)unemojify:(NSString *)string;

// Replace emoji unicode characters with codes, ignoring anything in ignore
// This is useful when you don't want to replace characters like TM with their emoji equivalent
+ (NSString *)unemojify:(NSString *)string ignore:(NSSet *)ignore;

@end

// Convenience category for emojifying a string
@interface NSString (ZWEmoji)

// Returns new string with all emoji codes replaced with their unicode equivalent
- (NSString *)zw_emojify;

@end
