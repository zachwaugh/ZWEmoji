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
	STAssertTrue([[ZWEmoji emojiForCode:@":smile:"] isEqualToString:@"😄"], nil);
	STAssertTrue([[ZWEmoji emojiForCode:@":moon:"] isEqualToString:@"🌙"], nil);
	STAssertTrue([[ZWEmoji emojiForCode:@":crocodile:"] isEqualToString:@"🐊"], nil);
	STAssertTrue([[ZWEmoji emojiForCode:@":snail:"] isEqualToString:@"🐌"], nil);
	STAssertTrue([[ZWEmoji emojiForCode:@":smiley_cat:"] isEqualToString:@"😺"], nil);
	STAssertTrue([[ZWEmoji emojiForCode:@":see_no_evil:"] isEqualToString:@"🙈"], nil);
	STAssertTrue([[ZWEmoji emojiForCode:@":thumbsup:"] isEqualToString:@"👍"], nil);
	STAssertTrue([[ZWEmoji emojiForCode:@":+1:"] isEqualToString:@"👍"], nil);
  STAssertTrue([[ZWEmoji emojiForCode:@":white_check_mark:"] isEqualToString:@"✅"], nil);
	
	// Make sure all emojis have a code
	for (NSString *emoji in [ZWEmoji emojis]) {
		STAssertNotNil([ZWEmoji codeForEmoji:emoji], nil);
	}
}

- (void)testEmojiForCode
{
	// Test some random emoji
	STAssertTrue([[ZWEmoji codeForEmoji:@"😄"] isEqualToString:@":smile:"], nil);
	STAssertTrue([[ZWEmoji codeForEmoji:@"🌙"] isEqualToString:@":moon:"], nil);
	STAssertTrue([[ZWEmoji codeForEmoji:@"🐊"] isEqualToString:@":crocodile:"], nil);
	STAssertTrue([[ZWEmoji codeForEmoji:@"🐌"] isEqualToString:@":snail:"], nil);
	STAssertTrue([[ZWEmoji codeForEmoji:@"😺"] isEqualToString:@":smiley_cat:"], nil);
	STAssertTrue([[ZWEmoji codeForEmoji:@"🙈"] isEqualToString:@":see_no_evil:"], nil);
	
	// This is a special case, multiple codes have the same emoji. Emoji will only map to one code though
	STAssertTrue([[ZWEmoji codeForEmoji:@"👍"] isEqualToString:@":+1:"] || [[ZWEmoji codeForEmoji:@"👍"] isEqualToString:@":thumbsup:"], nil);
	
	// Make sure all codes have an emoji
	for (NSString *code in [ZWEmoji codes]) {
		STAssertNotNil([ZWEmoji emojiForCode:code], nil);
	}
}


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
  NSDictionary *dict = nil;
  NSSet *replacedEmoji = nil;
	
  dict = [ZWEmoji replaceCodesInString:@":+1:"];
  NSString *string = [dict objectForKey:ZWEmojiStringKey];
	NSSet *replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
  STAssertTrue([string isEqualToString:@"👍"], nil);
  STAssertEqualObjects(replaced, [NSSet setWithObject:@"👍"], nil);
	
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":leaves:"] isEqualToString:@"🍃"], nil);
  dict = [ZWEmoji replaceCodesInString:@":leaves:"];
  string = [dict objectForKey:ZWEmojiStringKey];
	replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
  STAssertTrue([string isEqualToString:@"🍃"], nil);
	STAssertEqualObjects(replaced, [NSSet setWithObject:@"🍃"], nil);
  
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":leaves: and :lipstick:"] isEqualToString:@"🍃 and 💄"], nil);
  dict = [ZWEmoji replaceCodesInString:@":leaves: and :lipstick:"];
  string = [dict objectForKey:ZWEmojiStringKey];
	replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
	replacedEmoji = [NSSet setWithObjects:@"🍃", @"💄", nil];
  STAssertTrue([string isEqualToString:@"🍃 and 💄"], nil);
  STAssertEqualObjects(replaced, replacedEmoji, @"");
	
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@"thumbs up :+1: and thumbs down :-1:"] isEqualToString:@"thumbs up 👍 and thumbs down 👎"], nil);
  dict = [ZWEmoji replaceCodesInString:@"thumbs up :+1: and thumbs down :-1:"];
  string = [dict objectForKey:ZWEmojiStringKey];
	replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
	replacedEmoji = [NSSet setWithObjects:@"👍", @"👎", nil];
  STAssertTrue([string isEqualToString:@"thumbs up 👍 and thumbs down 👎"], nil);
	STAssertEqualObjects(replaced, replacedEmoji, nil);
	
  // STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":heart::heart::heart::heart::heart::heart:"] isEqualToString:@"❤❤❤❤❤❤"], nil);
  dict = [ZWEmoji replaceCodesInString:@":heart::heart::heart::heart::heart::heart:"];
  string = [dict objectForKey:ZWEmojiStringKey];
	replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
  STAssertTrue([string isEqualToString:@"❤❤❤❤❤❤"], nil);
	STAssertEqualObjects(replaced, [NSSet setWithObject:@"❤"], nil);
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

- (void)testMissing
{
	// These don't have unicode equivalent
	STAssertTrue([[ZWEmoji stringByReplacingCodesInString:@":trollface:"] isEqualToString:@":trollface:"], nil);
	STAssertTrue([[ZWEmoji emojiForCode:@":trollface:"] isEqualToString:@":trollface:"], nil);
	
	NSDictionary *dict = [ZWEmoji replaceCodesInString:@":+1: :trollface:"];
  NSString *string = [dict objectForKey:ZWEmojiStringKey];
	NSSet *replaced = [dict objectForKey:ZWEmojiReplacedEmojiKey];
  STAssertTrue([string isEqualToString:@"👍 :trollface:"], nil);
	NSSet *replacedSet = [NSSet setWithObjects:@"👍", @":trollface:", nil];
  STAssertEqualObjects(replaced, replacedSet, nil);
}

@end
