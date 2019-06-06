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
**#new**
```
doujinshi = Doujinshi.new(220794)
```

**#exists?**
```
doujinshi.exists?           #=> true
```

**#title**
```
doujinshi.title             #=> '[Illumination. (Ogadenmon)] Android no Ecchi na Yatsu | Horny Androids (NieR:Automata) [English] =TLL + mrwayne= [Digital]'
```

**#cover**
```
doujinshi.cover             #=> 'https://t.nhentai.net/galleries/1170172/cover.jpg'
```

**#page(page = 1)**
```
doujinshi.get_page          #=> 'https://i.nhentai.net/galleries/1170172/1.jpg'
doujinshi.get_page(10)      #=> 'https://i.nhentai.net/galleries/1170172/10.jpg'
```

**#pages**
```
doujinshi.pages             #=> ['https://i.nhentai.net/galleries/1170172/1.jpg',..., 'https://i.nhentai.net/galleries/1170172/31.jpg']
```

**#thumbnail(page = 1)**
```
doujinshi.get_thumbnail     #=> 'https://t.nhentai.net/galleries/1170172/1t.jpg'
doujinshi.get_thumbnail(10) #=> 'https://t.nhentai.net/galleries/1170172/10t.jpg'
```

**#thumbnails**
```
doujinshi.thumbnails        #=> ['https://t.nhentai.net/galleries/1170172/1t.jpg',..., 'https://t.nhentai.net/galleries/1170172/31t.jpg']
```

**#num_favorites**
```
doujinshi.num_favorites     #=> 13326
```

**#upload_date**
```
doujinshi.upload_date       #=> 2018-01-17 15:56:16 +0000
```

**#count_tags**  
The method #count_parodies, #count_characters, #count_artists, #count_groups, #count_languages and #count_categories work exactly the same way
```
doujinshi.count_tags        #=> 9
```

**#tags?**  
The method #parodies?, #characters?, #artists?, #groups?, #languages? and #categories? work exactly the same way
```
doujinshi.tags?             #=> true
```

## TODO
- [ ] better / real documentation of the API (use of YARD)
- [ ] basic search
- [ ] multiples words search
- [ ] exclude words search
- [ ] tags in search
- [ ] parodies page
- [ ] characters page
- [ ] artists page
- [ ] groups page
- [ ] languages page
- [ ] categories page

## Contributors

- [groussel42](https://github.com/groussel42) Gael Roussel - creator, maintainer