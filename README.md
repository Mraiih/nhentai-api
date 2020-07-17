[![Gem Version](https://badge.fury.io/rb/nhentai-api.png)](https://badge.fury.io/rb/nhentai-api)
![](https://ruby-gem-downloads-badge.herokuapp.com/nhentai-api?type=total&color=red&style=flat)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

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
puts Character.listing('2b')
```

## Documentation
You can read the documentation here: [https://www.rubydoc.info/github/groussel42/nhentai-api](https://www.rubydoc.info/github/groussel42/nhentai-api)

## TODO
**v1.0**
- [X] use of [YARD](https://yardoc.org/) for documentation
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
