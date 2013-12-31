//
//  ZWEmojiTests.h
//  ZWEmojiTests
//
//  Created by Zach Waugh on 8/31/12.
//  Copyright (c) 2012 Zach Waugh. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ZWEmojiTests : XCTestCase

- (void)testCodeForEmoji;
- (void)testEmojiForCode;
- (void)testStringSubstitution;
- (void)testDictionarySubstitution;
- (void)testReverseSubstitution;
- (void)testMissing;

@end
