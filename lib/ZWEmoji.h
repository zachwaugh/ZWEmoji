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
+ (NSString *)stringByReplacingCodesInString:(NSString *)string;

// Returns a dictionary that holds a string and array of emojis that were replaced
+ (NSDictionary *)replaceCodesInString:(NSString *)string;

// Replace emoji unicode characters with codes, allows users to input emoji directly
// without having to worry about the code
+ (NSString *)stringByReplacingEmojiInString:(NSString *)string;

// Replace emoji unicode characters with codes, ignoring anything in ignore
// This is useful when you don't want to replace characters like TM with their emoji equivalent
+ (NSString *)stringByReplacingEmojiInString:(NSString *)string ignore:(NSSet *)ignore;

@end
