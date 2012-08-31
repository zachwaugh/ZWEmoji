# ZWEmoji

ZWEmoji is a library for using emoji based on emoji codes used in Campfire/GitHub, documented here: [http://emoji-cheat-sheet.com](http://emoji-cheat-sheet.com). It can be used to go back and forth between the emoji codes and their unicode representation. This code was extracted from and currently used in [Flint](http://giantcomet.com/flint).

## Usage

All the functionality is contained in a single class `ZWEmoji`

The main calls are to replace codes with unicode and vice versa.

### Example

```
  NSString *string = @"This is a string with some emoji codes :smile: and :cry:";
  
  // Convert codes to unicode
  NSString *replaced = [ZWEmoji stringByReplacingCodesInString:string];
  
  // And back
  NSString *reversed = [ZWEmoji stringByReplacingEmojiInString:replaced];

```

## Demo

There is a demo app that displays all the emoji and their codes in a table, and also contains the tests

## Data

There is a sqlite database that stores all the emoji codes along with their unicode representation in data/emoji.db, and a script to export that to Objective-C in scripts/export.rb.

## To Do

On [emoji cheat sheet](http://emoji-cheat-sheet.com) and in OS X emoji picker (Edit > Special Characters > Emoji in almost any text editor), the emoji are grouped by category. I want to add those categories to the database.

## Notes

There are currently 18 emoji listed in [emoji cheat sheet](http://emoji-cheat-sheet.com) that this library doesn't support because they're part of the unicode standard or I couldn't find a match. They are:

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

## License

Licensed under the MIT license.

