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
```ruby
gem 'nhentai-api', '~> 1.0'
```

## API
```ruby
doujinshi = Doujinshi.new(id: 220794)
puts doujinshi.title
puts doujinshi.pages
puts doujinshi.related

puts Doujinshi.random

puts Tag.new(keyword: 'ahegao').listing
puts Character.new(keyword: '2b', sort: :all_time, page: 5).listing

options = {
  keywords: { included: ["girl"] },
  pages: [">= 10", "<= 200"]
}
puts Search.new(options: options).listing
```

## Documentation
The [wiki](https://github.com/Mraiih/nhentai-api/wiki/Documentation) contains the list of all methods with examples

## Contributors
- [Mraiih](https://github.com/Mraiih) Gael Roussel - creator, maintainer
