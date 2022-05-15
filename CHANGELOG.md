# Upcoming (1.0?)
### Add
- [[12a145a](https://github.com/Mraiih/nhentai-api/commit/12a145a15ae1b5d116470c9de189a38da4890b49)] Search class with `#count` and `#listing` method
### Fixes
- [[afa0122](https://github.com/Mraiih/nhentai-api/commit/afa0122ec958507de7ac812623dfcbfd18bec2e1)] `.count` method should work with numbers >= 1000
### Others
- **BREAKING CHANGES** `.count` and `.listing` class method for Tag Parody Character Artist Group Language and Category classes will now be instance variable
- **BREAKING CHANGES** `.new` method for Tag Parody Character Artist Group Language and Category classes will now require named parameters instead of positional  parameters
- **BREAKING CHANGES** `.new`, `#page`, `#thumbnail` methods for Doujinshi class will now require named parameter instead of positional parameter
- Cleanup some code

# 0.3
### Add
- [[bc7d7e5](https://github.com/Mraiih/nhentai-api/commit/bc7d7e57f246e0ffd91cb9ef2ffeaf5804c07d11)] Add `.count` method for Tag/Parody/Character/Artist/Group/Language/Category classes

### Fixes
- [[cf73cee](https://github.com/Mraiih/nhentai-api/commit/cf73cee9300ff07456a092b8a5d804556560f308)] Doujinshi name will no longer give some random html code anymore
- [[bc7d7e5](https://github.com/Mraiih/nhentai-api/commit/bc7d7e57f246e0ffd91cb9ef2ffeaf5804c07d11)] Thumbnails will correctly be retrieve

### Other
- Cleanup some code
- Remove Yard doc (wiki incoming)
