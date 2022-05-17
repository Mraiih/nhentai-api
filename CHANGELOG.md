# Upcoming (1.0)
### Add
- [[12a145a](https://github.com/Mraiih/nhentai-api/commit/12a145a15ae1b5d116470c9de189a38da4890b49)] Search class with `#count` and `#listing` method
### Fixes
- [[afa0122](https://github.com/Mraiih/nhentai-api/commit/afa0122ec958507de7ac812623dfcbfd18bec2e1)] `.count` method should work with numbers >= 1000
### Others
- [[13629c3](https://github.com/Mraiih/nhentai-api/commit/13629c3333a1d98f698ae60a57e3b83b2b18f418)] **BREAKING CHANGES** `.count` and `.listing` class method for Tag Parody Character Artist Group Language and Category classes will now be instance variable
- [[13629c3](https://github.com/Mraiih/nhentai-api/commit/13629c3333a1d98f698ae60a57e3b83b2b18f418)] **BREAKING CHANGES** `.new` method for Tag Parody Character Artist Group Language and Category classes will now require named parameters instead of positional  parameters
- [[13629c3](https://github.com/Mraiih/nhentai-api/commit/13629c3333a1d98f698ae60a57e3b83b2b18f418)] **BREAKING CHANGES** `.new`, `#page`, `#thumbnail` methods for Doujinshi class will now require named parameter instead of positional parameter
- [[03cdb73](https://github.com/Mraiih/nhentai-api/commit/03cdb7358e83dd2191190b194cfa38e15c2c1a7a)] **BREAKING CHANGES** `sort` argument will now receive a symbol instead of an integer, options will be `:none`, `:today`, `:week`, `:all_time`
- Cleanup some code
- [[8c155ae](https://github.com/Mraiih/nhentai-api/commit/8c155ae1b2b6127d2b0f6bd3bb03a231fd9ec4fa)] Use api for retreiving doujin information
- Use api for search

# 0.3
### Add
- [[bc7d7e5](https://github.com/Mraiih/nhentai-api/commit/bc7d7e57f246e0ffd91cb9ef2ffeaf5804c07d11)] Add `.count` method for Tag/Parody/Character/Artist/Group/Language/Category classes

### Fixes
- [[cf73cee](https://github.com/Mraiih/nhentai-api/commit/cf73cee9300ff07456a092b8a5d804556560f308)] Doujinshi name will no longer give some random html code anymore
- [[bc7d7e5](https://github.com/Mraiih/nhentai-api/commit/bc7d7e57f246e0ffd91cb9ef2ffeaf5804c07d11)] Thumbnails will correctly be retrieve

### Other
- Cleanup some code
- Remove Yard doc (wiki incoming)
