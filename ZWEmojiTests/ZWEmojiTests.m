//
//  ZWEmojiTests.m
//  ZWEmojiTests
//
//  Created by Zach Waugh on 8/31/12.
//  Copyright (c) 2012 Zach Waugh. All rights reserved.
//

#import "ZWEmojiTests.h"
#import "ZWEmoji.h"

@implementation ZWEmojiTests

- (void)testCodeForEmoji
{
	// Test some random emoji and make sure the code matches the unicode representation
	XCTAssertTrue([[ZWEmoji emojiForCode:@":smile:"] isEqualToString:@"😄"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":moon:"] isEqualToString:@"🌙"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":crocodile:"] isEqualToString:@"🐊"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":snail:"] isEqualToString:@"🐌"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":smiley_cat:"] isEqualToString:@"😺"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":see_no_evil:"] isEqualToString:@"🙈"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":thumbsup:"] isEqualToString:@"👍"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":+1:"] isEqualToString:@"👍"]);
    XCTAssertTrue([[ZWEmoji emojiForCode:@":white_check_mark:"] isEqualToString:@"✅"]);
    XCTAssertTrue([[ZWEmoji emojiForCode:@":worried:"] isEqualToString:@"😟"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":aerial_tramway:"] isEqualToString:@"🚡"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":hamburger:"] isEqualToString:@"🍔"]);
	
	// Make sure all emojis have a code
	for (NSString *emoji in [ZWEmoji emojis]) {
		XCTAssertNotNil([ZWEmoji codeForEmoji:emoji]);
	}
}

- (void)testEmojiForCode
{
	// Test some random emoji
	XCTAssertTrue([[ZWEmoji codeForEmoji:@"😄"] isEqualToString:@":smile:"]);
	XCTAssertTrue([[ZWEmoji codeForEmoji:@"🌙"] isEqualToString:@":moon:"]);
	XCTAssertTrue([[ZWEmoji codeForEmoji:@"🐊"] isEqualToString:@":crocodile:"]);
	XCTAssertTrue([[ZWEmoji codeForEmoji:@"🐌"] isEqualToString:@":snail:"]);
	XCTAssertTrue([[ZWEmoji codeForEmoji:@"😺"] isEqualToString:@":smiley_cat:"]);
	XCTAssertTrue([[ZWEmoji codeForEmoji:@"🙈"] isEqualToString:@":see_no_evil:"]);
	XCTAssertTrue([[ZWEmoji codeForEmoji:@"🍔"] isEqualToString:@":hamburger:"]);
	
	// This is a special case, multiple codes have the same emoji. Emoji will only map to one code though
	XCTAssertTrue([[ZWEmoji codeForEmoji:@"👍"] isEqualToString:@":+1:"] || [[ZWEmoji codeForEmoji:@"👍"] isEqualToString:@":thumbsup:"]);
	
	// Make sure all codes have an emoji
	for (NSString *code in [ZWEmoji codes]) {
		XCTAssertNotNil([ZWEmoji emojiForCode:code]);
	}
}


// Substitute codes for unicode
- (void)testStringSubstitution
{
  XCTAssertTrue([[ZWEmoji emojify:@":+1:"] isEqualToString:@"👍"]);
  XCTAssertTrue([[ZWEmoji emojify:@":leaves:"] isEqualToString:@"🍃"]);
  XCTAssertTrue([[ZWEmoji emojify:@":leaves: and :smile:"] isEqualToString:@"🍃 and 😄"]);
  XCTAssertTrue([[ZWEmoji emojify:@":-1:"] isEqualToString:@"👎"]);
  XCTAssertTrue([[ZWEmoji emojify:@":+1: :-1:"] isEqualToString:@"👍 👎"]);
  XCTAssertTrue([[ZWEmoji emojify:@":+1: and :-1:"] isEqualToString:@"👍 and 👎"]);
  XCTAssertTrue([[ZWEmoji emojify:@"thumbs up :+1: and thumbs down :-1:"] isEqualToString:@"thumbs up 👍 and thumbs down 👎"]);
  XCTAssertTrue([[ZWEmoji emojify:@":heart::heart::heart::heart::heart::heart:"] isEqualToString:@"❤❤❤❤❤❤"]);
  XCTAssertTrue([[ZWEmoji emojify:@"blah:+1: and thumbs down :-1:"] isEqualToString:@"blah👍 and thumbs down 👎"]);
  
  XCTAssertFalse([[ZWEmoji emojify:@":+1"] isEqualToString:@"👍"]);
  XCTAssertFalse([[ZWEmoji emojify:@":-1:"] isEqualToString:@"👍"]);
}


- (void)testDictionarySubstitution
{
  NSDictionary *dict = nil;
  NSSet *replacedEmoji = nil;
	
  dict = [ZWEmoji replaceCodesInString:@":+1:"];
  NSString *string = [dict objectForKey:ZWEmojiStringKey];
	NSSet *replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
  XCTAssertTrue([string isEqualToString:@"👍"]);
  XCTAssertEqualObjects(replaced, [NSSet setWithObject:@"👍"]);
	
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":leaves:"] isEqualToString:@"🍃"], nil);
  dict = [ZWEmoji replaceCodesInString:@":leaves:"];
  string = [dict objectForKey:ZWEmojiStringKey];
	replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
  XCTAssertTrue([string isEqualToString:@"🍃"]);
	XCTAssertEqualObjects(replaced, [NSSet setWithObject:@"🍃"]);
  
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":leaves: and :lipstick:"] isEqualToString:@"🍃 and 💄"], nil);
  dict = [ZWEmoji replaceCodesInString:@":leaves: and :lipstick:"];
  string = [dict objectForKey:ZWEmojiStringKey];
	replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
	replacedEmoji = [NSSet setWithObjects:@"🍃", @"💄", nil];
  XCTAssertTrue([string isEqualToString:@"🍃 and 💄"]);
  XCTAssertEqualObjects(replaced, replacedEmoji, @"");
	
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@"thumbs up :+1: and thumbs down :-1:"] isEqualToString:@"thumbs up 👍 and thumbs down 👎"], nil);
  dict = [ZWEmoji replaceCodesInString:@"thumbs up :+1: and thumbs down :-1:"];
  string = [dict objectForKey:ZWEmojiStringKey];
	replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
	replacedEmoji = [NSSet setWithObjects:@"👍", @"👎", nil];
  XCTAssertTrue([string isEqualToString:@"thumbs up 👍 and thumbs down 👎"]);
	XCTAssertEqualObjects(replaced, replacedEmoji);
	
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":heart::heart::heart::heart::heart::heart:"] isEqualToString:@"❤❤❤❤❤❤"], nil);
  dict = [ZWEmoji replaceCodesInString:@":heart::heart::heart::heart::heart::heart:"];
  string = [dict objectForKey:ZWEmojiStringKey];
	replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
  XCTAssertTrue([string isEqualToString:@"❤❤❤❤❤❤"]);
	XCTAssertEqualObjects(replaced, [NSSet setWithObject:@"❤"]);
}

// Replace unicode with code
- (void)testReverseSubstitution
{	
  XCTAssertTrue([[ZWEmoji unemojify:@"😄"] isEqualToString:@":smile:"]);
  XCTAssertTrue([[ZWEmoji unemojify:@"\U0001F604"] isEqualToString:@":smile:"]);
  XCTAssertTrue([[ZWEmoji unemojify:@"\u2122"] isEqualToString:@":tm:"]);
  XCTAssertTrue([[ZWEmoji unemojify:@"🍃"] isEqualToString:@":leaves:"]);
  XCTAssertTrue([[ZWEmoji unemojify:@"🍃 and 💄"] isEqualToString:@":leaves: and :lipstick:"]);
  XCTAssertTrue([[ZWEmoji unemojify:@"😢"] isEqualToString:@":cry:"]);
  XCTAssertTrue([[ZWEmoji unemojify:@"😄 😢"] isEqualToString:@":smile: :cry:"]);
  XCTAssertTrue([[ZWEmoji unemojify:@"😄 and 😢"] isEqualToString:@":smile: and :cry:"]);
  XCTAssertTrue([[ZWEmoji unemojify:@"smile 😄 and cry 😢"] isEqualToString:@"smile :smile: and cry :cry:"]);
  
  XCTAssertTrue([[ZWEmoji unemojify:@"blah😄 and asdfasdf 😢"] isEqualToString:@"blah:smile: and asdfasdf :cry:"]);
  
  XCTAssertFalse([[ZWEmoji unemojify:@"👍"] isEqualToString:@":+1"]);
  XCTAssertFalse([[ZWEmoji unemojify:@"👍"] isEqualToString:@":-1:"]);
  
  // Ignore
  XCTAssertTrue([[ZWEmoji unemojify:@"\u2122" ignore:[NSSet setWithObject:@"\u2122"]] isEqualToString:@"\u2122"]);
  XCTAssertTrue([[ZWEmoji unemojify:@"\u2122 and 👍" ignore:[NSSet setWithObject:@"\u2122"]] isEqualToString:@"\u2122 and :+1:"]);
  NSSet *ignore = [NSSet setWithObjects:@"\u2122", @"\U0001F44D", nil];
  XCTAssertTrue([[ZWEmoji unemojify:@"\u2122 and 👍" ignore:ignore] isEqualToString:@"\u2122 and 👍"]);
}

- (void)testMissing
{
	// These don't have unicode equivalent
	XCTAssertTrue([[ZWEmoji emojify:@":trollface:"] isEqualToString:@":trollface:"]);
	XCTAssertTrue([[ZWEmoji emojiForCode:@":trollface:"] isEqualToString:@":trollface:"]);
	
	NSDictionary *dict = [ZWEmoji replaceCodesInString:@":+1: :trollface:"];
    NSString *string = dict[ZWEmojiStringKey];
	NSSet *replaced = dict[ZWEmojiReplacedEmojiKey];
    XCTAssertTrue([string isEqualToString:@"👍 :trollface:"]);
	NSSet *replacedSet = [NSSet setWithObjects:@"👍", @":trollface:", nil];
    XCTAssertEqualObjects(replaced, replacedSet);
}

@end
