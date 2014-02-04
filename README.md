# ZWEmoji

ZWEmoji is a library for using emoji based on emoji codes used in Campfire/GitHub, documented here: [http://emoji-cheat-sheet.com](http://emoji-cheat-sheet.com). It can be used to go back and forth between the emoji codes and their unicode representation. This code was extracted from and currently used in [Flint](http://giantcomet.com/flint).

## Usage

All the functionality is contained in a single class `ZWEmoji`

The main calls are to replace codes with unicode and vice versa.

### Example

```
  NSString *string = @"This is a string with some emoji codes :smile: and :cry:";
  
  // Convert codes to unicode
  NSString *replaced = [ZWEmoji emojify:string];
  
  // And back
  NSString *reversed = [ZWEmoji unemojify:replaced];

```

## Demo

There is a demo app that displays all the emoji and their codes in a table, and also contains the tests

## Data

There is a CSV file that stores all the emoji codes along with their unicode representation in data/emoji.csv, and a script to export that to Objective-C in scripts/export.rb. Currently, exporting involves exporting to the clipboard and pasting into ZWEmoji.m to replace the dictionary. Should probably export to a separate data file that gets loaded at runtime, but this is simpler for now as I want the lib to be a single class

## To Do

- On [emoji cheat sheet](http://emoji-cheat-sheet.com) and in OS X emoji picker (Edit > Special Characters > Emoji in almost any text editor), the emoji are grouped by category. I want to add those categories to the database.
- Write a script to compare against [emoji cheat sheet](http://emoji-cheat-sheet.com) and [Gemoji](http://github.com/github/gemoji) to ensure we have full support

## Notes

There are currently 18 emoji listed in [emoji cheat sheet](http://emoji-cheat-sheet.com) that this library doesn't support because they're not part of the unicode standard or I couldn't find a match. They are:

- 109
- bowtie
- feelsgood
- finnadie
- goberserk
- godmode
- hurtrealbad
- metal
- neckbeard
- octocat
- rage1
- rage2
- rage3
- rage4
- shipit
- squirrel
- suspect
- trollface

They're still included in the library, but are just replaced with themselves, so you can replace them with images if you want.

## License

Licensed under the MIT license.

Copyright (c) 2012 Zach Waugh

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

