//
//  ZWEmojiTests.m
//  ZWEmojiTests
//
//  Created by Zach Waugh on 8/31/12.
//  Copyright (c) 2012 Zach Waugh. All rights reserved.
//

#import "ZWEmojiTests.h"
#import "ZWEmoji.h"

@interface NSString	(Ranges)

- (NSArray *)rangesOfString:(NSString *)string;
- (NSArray *)rangesOfString:(NSString *)string options:(NSStringCompareOptions)options;

@end

@implementation NSString (Ranges)

- (NSArray *)rangesOfString:(NSString *)string
{
  return [self rangesOfString:string options:0];
}

- (NSArray *)rangesOfString:(NSString *)string options:(NSStringCompareOptions)options
{
  NSUInteger length = [self length];
  NSRange range = NSMakeRange(0, length);
  NSMutableArray *ranges = [NSMutableArray array];
  
  while (range.location != NSNotFound) {
    range = [self rangeOfString:string options:options range:range];
    
    if (range.location != NSNotFound) {
      [ranges addObject:[NSValue valueWithRange:range]];
      range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
    }
  }
  
  return ranges;
}

@end

@implementation ZWEmojiTests

// Substitute codes for unicode
- (void)testStringSubstitution
{
  STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":+1:"] isEqualToString:@"👍"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":leaves:"] isEqualToString:@"🍃"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":leaves: and :smile:"] isEqualToString:@"🍃 and 😄"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":-1:"] isEqualToString:@"👎"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":+1: :-1:"] isEqualToString:@"👍 👎"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":+1: and :-1:"] isEqualToString:@"👍 and 👎"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@"thumbs up :+1: and thumbs down :-1:"] isEqualToString:@"thumbs up 👍 and thumbs down 👎"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":heart::heart::heart::heart::heart::heart:"] isEqualToString:@"❤❤❤❤❤❤"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@"blah:+1: and thumbs down :-1:"] isEqualToString:@"blah👍 and thumbs down 👎"], nil);
  
  STAssertFalse([[ZWEmoji stringByReplacingCodesInString:@":+1"] isEqualToString:@"👍"], nil);
  STAssertFalse([[ZWEmoji stringByReplacingCodesInString:@":-1:"] isEqualToString:@"👍"], nil);
}


- (void)testDictionarySubstitution
{
  NSDictionary *dict;
  
  dict = [ZWEmoji replaceCodesInString:@":+1:"];
  NSString *string = [dict objectForKey:@"string"];
  STAssertTrue([string isEqualToString:@"👍"], nil);
  
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":leaves:"] isEqualToString:@"🍃"], nil);
  dict = [ZWEmoji replaceCodesInString:@":leaves:"];
  string = [dict objectForKey:@"string"];
  STAssertTrue([string isEqualToString:@"🍃"], nil);
  
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":leaves: and :lipstick:"] isEqualToString:@"🍃 and 💄"], nil);
  dict = [ZWEmoji replaceCodesInString:@":leaves: and :lipstick:"];
  string = [dict objectForKey:@"string"];
  STAssertTrue([string isEqualToString:@"🍃 and 💄"], nil);
  
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@"thumbs up :+1: and thumbs down :-1:"] isEqualToString:@"thumbs up 👍 and thumbs down 👎"], nil);
  dict = [ZWEmoji replaceCodesInString:@"thumbs up :+1: and thumbs down :-1:"];
  string = [dict objectForKey:@"string"];
  STAssertTrue([string isEqualToString:@"thumbs up 👍 and thumbs down 👎"], nil);
  
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":heart::heart::heart::heart::heart::heart:"] isEqualToString:@"❤❤❤❤❤❤"], nil);
  dict = [ZWEmoji replaceCodesInString:@":heart::heart::heart::heart::heart::heart:"];
  string = [dict objectForKey:@"string"];
  STAssertTrue([string isEqualToString:@"❤❤❤❤❤❤"], nil);
}

// Replace unicode with code
- (void)testReverseSubstitution
{	
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"😄"] isEqualToString:@":smile:"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"\U0001F604"] isEqualToString:@":smile:"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"\u2122"] isEqualToString:@":tm:"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"🍃"] isEqualToString:@":leaves:"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"🍃 and 💄"] isEqualToString:@":leaves: and :lipstick:"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"😢"] isEqualToString:@":cry:"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"😄 😢"] isEqualToString:@":smile: :cry:"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"😄 and 😢"] isEqualToString:@":smile: and :cry:"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"smile 😄 and cry 😢"] isEqualToString:@"smile :smile: and cry :cry:"], nil);
  
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"blah😄 and asdfasdf 😢"] isEqualToString:@"blah:smile: and asdfasdf :cry:"], nil);
  
  STAssertFalse([[ZWEmoji stringByReplacingEmojiInString:@"👍"] isEqualToString:@":+1"], nil);
  STAssertFalse([[ZWEmoji stringByReplacingEmojiInString:@"👍"] isEqualToString:@":-1:"], nil);
  
  // Ignore
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"\u2122" ignore:[NSSet setWithObject:@"\u2122"]] isEqualToString:@"\u2122"], nil);
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"\u2122 and 👍" ignore:[NSSet setWithObject:@"\u2122"]] isEqualToString:@"\u2122 and :+1:"], nil);
  NSSet *ignore = [NSSet setWithObjects:@"\u2122", @"\U0001F44D", nil];
  STAssertTrue([[ZWEmoji stringByReplacingEmojiInString:@"\u2122 and 👍" ignore:ignore] isEqualToString:@"\u2122 and 👍"], nil);
}

@end
