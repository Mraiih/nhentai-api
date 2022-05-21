# 1.0.1 - May 21, 2022
### Fixes
- Files required

# 1.0 - May 20, 2022
### Add
- [[12a145a](https://github.com/Mraiih/nhentai-api/commit/12a145a15ae1b5d116470c9de189a38da4890b49)] Search class with `#count` and `#listing` method
- [[779d115](https://github.com/Mraiih/nhentai-api/commit/779d1154d8cc74689db86349544d517f10f7635f)] Doujinshi now have `.random` class method and `#related` method
### Fixes
- [[afa0122](https://github.com/Mraiih/nhentai-api/commit/afa0122ec958507de7ac812623dfcbfd18bec2e1)] `.count` method should work with numbers >= 1000
### Others
- [[13629c3](https://github.com/Mraiih/nhentai-api/commit/13629c3333a1d98f698ae60a57e3b83b2b18f418)] **BREAKING CHANGES** `.count` and `.listing` class method for Tag Parody Character Artist Group Language and Category classes will now be instance variable
- [[13629c3](https://github.com/Mraiih/nhentai-api/commit/13629c3333a1d98f698ae60a57e3b83b2b18f418)] **BREAKING CHANGES** `.new` method for Tag Parody Character Artist Group Language and Category classes will now require named parameters instead of positional  parameters
- [[13629c3](https://github.com/Mraiih/nhentai-api/commit/13629c3333a1d98f698ae60a57e3b83b2b18f418)] **BREAKING CHANGES** `.new`, `#page`, `#thumbnail` methods for Doujinshi class will now require named parameter instead of positional parameter
- [[03cdb73](https://github.com/Mraiih/nhentai-api/commit/03cdb7358e83dd2191190b194cfa38e15c2c1a7a)] **BREAKING CHANGES** `sort` argument will now receive a symbol instead of an integer, options will be `:none`, `:today`, `:week`, `:all_time`
- [[8c155ae](https://github.com/Mraiih/nhentai-api/commit/8c155ae1b2b6127d2b0f6bd3bb03a231fd9ec4fa)] Use api for retreiving doujin information
- [[c153355](https://github.com/Mraiih/nhentai-api/commit/c153355106a2e6ca0dcf601ed05b1a7e2be723be)] Use api for search
- Cleanup some code

# 0.3 - May 14, 2022
### Add
- [[bc7d7e5](https://github.com/Mraiih/nhentai-api/commit/bc7d7e57f246e0ffd91cb9ef2ffeaf5804c07d11)] Add `.count` method for Tag/Parody/Character/Artist/Group/Language/Category classes
### Fixes
- [[cf73cee](https://github.com/Mraiih/nhentai-api/commit/cf73cee9300ff07456a092b8a5d804556560f308)] Doujinshi name will no longer give some random html code anymore
- [[bc7d7e5](https://github.com/Mraiih/nhentai-api/commit/bc7d7e57f246e0ffd91cb9ef2ffeaf5804c07d11)] Thumbnails will correctly be retrieve
### Others
- Cleanup some code
- Remove Yard doc

# 0.2.2 - July 17, 2020
### Fixes
- Count pages attribute will now be correctly scrapped
- Title will now be correctly scrapped, using pretty title
- Tags returns an emtpy array instead of nil when regex won't find any data

# 0.2.1 - January 19, 2020
### Fixes
- Doujinshi's will correctly retrieve the cover

# 0.2.0 - June 10, 2019
### Add
- Retrieve Tag Parody Character Artist Group Language and Category

# 0.1.3 - June 08, 2019
### Others
- Add Yard documentation

# 0.1.2 - June 08, 2019 
### Others
- Replace methods
- Use iso8601 for Time

# 0.1.1 - June 06, 2019
### Others
- Changed gemspec's metadata
