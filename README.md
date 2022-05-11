[![Gem Version](https://badge.fury.io/rb/nhentai-api.png)](https://badge.fury.io/rb/nhentai-api)
![](https://ruby-gem-downloads-badge.herokuapp.com/nhentai-api?type=total&color=red&style=flat)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Maintainability](https://api.codeclimate.com/v1/badges/02e6104284d2f96e502c/maintainability)](https://codeclimate.com/github/Mraiih/nhentai-api/maintainability)

# nhentai-api

nhentai-api is a basic and easy to use API for [nhentai.net](https://nhentai.net)

## Installation

Gem install
```
gem install nhentai-api
```

Gemfile
```
gem 'nhentai-api'
```

## API
```
doujinshi = Doujinshi.new(220794)
puts doujinshi.title
puts doujinshi.pages

puts Tag.listing('ahegao')
puts Character.listing('2b', 0, 1)
```

## Methods
Doujinshi#new  
Doujinshi#exists?  
Doujinshi#title  
Doujinshi#cover  
Doujinshi#page  
Doujinshi#pages  
Doujinshi#thumbnail  
Doujinshi#thumbnails  
Doujinshi#count_favorites  
Doujinshi#upload_date  

Doujinshi#tags  
Doujinshi#count_tags  
Doujinshi#tags?  
Doujinshi#parodies  
Doujinshi#count_parodies  
Doujinshi#parodies?  
Doujinshi#characters  
Doujinshi#count_characters  
Doujinshi#characters?  
Doujinshi#artists  
Doujinshi#count_artists  
Doujinshi#artists?  
Doujinshi#groups  
Doujinshi#count_groups  
Doujinshi#groups?  
Doujinshi#languages  
Doujinshi#count_languages  
Doujinshi#languages?  
Doujinshi#categories  
Doujinshi#count_categories  
Doujinshi#categories?  

Tag.listing  
Parody.listing  
Character.listing  
Artist.listing  
Group.listing  
Language.listing  
Category.listing  

## TODO
**v1.0**
- [ ] basic search
- [ ] multiples words search
- [ ] exclude words search
- [ ] tags in search
- [x] tag page
- [x] parody page
- [x] character page
- [x] artist page
- [x] group page
- [x] language page
- [x] category page

## Contributors

- [Mraiih](https://github.com/Mraiih) Gael Roussel - creator, maintainer
