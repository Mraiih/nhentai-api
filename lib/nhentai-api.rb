require 'net/http'
require 'time'

class Info
  attr_reader :id, :name, :count, :url

  def initialize(id, name, count, url)
    @id     = id
    @name   = name
    @count  = count
    @url    = url
  end
end

class Doujinshi
  attr_reader :id, :client, :media_id, :count_pages

  def initialize(id)
    @id           = id
    @client       = Net::HTTP.get_response(URI("https://nhentai.net/g/#{@id}/"))
    if self.exists?
      @media_id     = @client.body.match(%r{\/([0-9]+)\/cover})[1]
      @count_pages  = @client.body.match(/([0-9]+) pages/)[1].to_i
    end
  end

  #
  # Check if a doujinshi with the given id exist
  #
  # @return [Bool] true if the doujinshi exist, otherwise false
  # @since 0.1.0
  # @example
  #   doujinshi.exists?   #=> true
  #
  def exists?
    @client.code == '200'
  end

  #
  # Give the title of a doujinshi
  #
  # @return [String] the title of a given doujinshi
  # @since 0.1.0
  # @example
  #   doujinshi.title   #=> '[Illumination. (Ogadenmon)] Android no Ecchi na Yatsu | Horny Androids (NieR:Automata) [English] =TLL + mrwayne= [Digital]'
  #
  def title
    @client.body.match(%r{<div id="info">\s+<h1>(.+)<\/h1>})[1]
  end

  #
  # Give the cover's URL of a doujinshi
  #
  # @return [String] the cover's URL of a given doujinshi
  # @since 0.1.0
  # @example
  #   doujinshi.cover   #=> 'https://t.nhentai.net/galleries/1170172/cover.jpg'
  #
  def cover
    res = @client.body.match(%r{https://t.nhentai.net/galleries/#{@media_id}/cover\.(.{3})"})

    "https://t.nhentai.net/galleries/#{@media_id}/cover.#{res[1]}"
  end

  #
  # Give the URL of a given page of a doujinshi
  #
  # @param [Integer] page a particular page of a doujinshi
  # @return [String] the URL of a given page of a doujinshi
  # @since 0.1.0
  # @example
  #   doujinshi.get_page        #=> 'https://i.nhentai.net/galleries/1170172/1.jpg'
  #   doujinshi.get_page(10)    #=> 'https://i.nhentai.net/galleries/1170172/10.jpg'
  #
  def page(page = 1)
    res = @client.body.match(%r{https://t.nhentai.net/galleries/#{@media_id}/#{page}t\.(.{3})"})

    "https://i.nhentai.net/galleries/#{@media_id}/#{page}.#{res[1]}"
  end

  #
  # Give the URL of a all pages of a doujinshi
  #
  # @return [Array] array pages' URL
  # @since 0.1.0
  # @example
  #   doujinshi.pages   #=> ['https://i.nhentai.net/galleries/1170172/1.jpg', ..., 'https://i.nhentai.net/galleries/1170172/31.jpg']
  #
  def pages
    (1..@count_pages).map { |page| page(page) }
  end

  #
  # Give the thumbnail's URL of a given page of a doujinshi
  #
  # @param [Integer] page a particular page of a doujinshi
  # @return [String] the thumbnail's URL of a given page of a doujinshi
  # @since 0.1.0
  # @example
  #   doujinshi.get_thumbnail       #=> 'https://t.nhentai.net/galleries/1170172/1t.jpg'
  #   doujinshi.get_thumbnail(10)   #=> 'https://t.nhentai.net/galleries/1170172/10t.jpg'
  #
  def thumbnail(page = 1)
    res = @client.body.match(%r{https://t.nhentai.net/galleries/#{@media_id}/(#{page}t\..{3})"})

    "https://t.nhentai.net/galleries/#{@media_id}/#{res[1]}"
  end

  #
  # Give the URL of a all thumbnails of a doujinshi
  #
  # @return [Array] an array thumbnails' URL
  # @since 0.1.0
  # @example
  #   doujinshi.thumbnails    #=> ['https://t.nhentai.net/galleries/1170172/1t.jpg',..., 'https://t.nhentai.net/galleries/1170172/31t.jpg']
  #
  def thumbnails
    (1..@count_pages).map { |page| thumbnail(page) }
  end

  #
  # Give the number of favorites on a doujinshi
  #
  # @return [Integer] a counter of favorites on a given doujinshi
  # @since 0.1.0
  # @example
  #   doujinshi.num_favorites   #=> 13326
  #
  def count_favorites
    regex = %r{<span>Favorite <span class="nobold">.(\d+).<\/span><\/span>}

    @client.body.match(regex)[1].to_i
  end

  #
  # Give the upload date of a doujinshi
  #
  # @return [Integer] the upload date of a given doujinshi
  # @since 0.1.0
  # @example
  #   doujinshi.upload_date   #=> 2018-01-17 15:56:16 +0000
  #
  def upload_date
    Time.iso8601(@client.body.match(/datetime="(.+)"/)[1])
  end

  #
  # Give all tags of a doujinshi
  #
  # @return [Array] of Tag class of a given doujinshi
  # @since 0.1.0
  # @example
  #   doujinshi.tags
  #
  def tags
    res = @client.body.match(%r{Tags:\s*<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  #
  # Give a counter of tags
  #
  # @return [Integer] of tags
  # @since 0.1.0
  # @example
  #   doujinshi.count_tags    #=> 9
  #
  def count_tags
    res = @client.body.match(%r{Tags:\s*<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).length
  end

  #
  # Check if a particular doujinshi have some tags
  #
  # @return [Bool] true if the doujinshi have tags, otherwise false
  # @since 0.1.0
  # @example
  #   doujinshi.tags?   #=> true
  #
  def tags?
    !@client.body.match(%r{Tags:\s*<span class="tags">(.+)<\/span>}).nil?
  end

  #
  # Give all parodies of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #
  def parodies
    res = @client.body.match(%r{Parodies:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  #
  # Give a counter of parodies
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #
  def count_parodies
    res = @client.body.match(%r{Parodies:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).length
  end

  #
  # Check if a particular doujinshi have some parodies
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #
  def parodies?
    !@client.body.match(%r{Parodies:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  #
  # Give all characters of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #
  def characters
    res = @client.body.match(%r{Characters:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  #
  # Give a counter of characters
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #
  def count_characters
    res = @client.body.match(%r{Characters:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).length
  end

  #
  # Check if a particular doujinshi have some characters
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #
  def characters?
    !@client.body.match(%r{Characters:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  #
  # Give all artists of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #
  def artists
    res = @client.body.match(%r{Artists:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  #
  # Give a counter of artists
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #
  def count_artists
    res = @client.body.match(%r{Artists:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).length
  end

  #
  # Check if a particular doujinshi have some artists
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #
  def artists?
    !@client.body.match(%r{Artists:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  #
  # Give all groups of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #
  def groups
    res = @client.body.match(%r{Groups:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  #
  # Give a counter of groups
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #
  def count_groups
    res = @client.body.match(%r{Groups:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).length
  end

  #
  # Check if a particular doujinshi have some groups
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #
  def groups?
    !@client.body.match(%r{Groups:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  #
  # Give all languages of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #
  def languages
    res = @client.body.match(%r{Languages:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  #
  # Give a counter of languages
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #
  def count_languages
    res = @client.body.match(%r{Languages:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).length
  end

  #
  # Check if a particular doujinshi have some languages
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #
  def languages?
    !@client.body.match(%r{Languages:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  #
  # Give all categories of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #
  def categories
    res = @client.body.match(%r{Categories:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  #
  # Give a counter of categories
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #
  def count_categories
    res = @client.body.match(%r{Categories:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).length
  end

  #
  # Check if a particular doujinshi have some categories
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #
  def categories?
    !@client.body.match(%r{Categories:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  #
  # @private
  #

  private

  def parse_tags(res)
    res.split(%r{<a(.+?)<\/a>}).reject(&:empty?).map do |line|
      id    = line.match(/tag-(\d+)/)[1]
      name  = line.match(/">(.+?)</)[1].strip
      count = line.match(/\((.+?)\)</)[1].tr(',', '').to_i
      url   = line.match(/href=\"(.+?)\"/)[1]

      Info.new(id, name, count, url)
    end
  end
end

class Tag
  #
  # List all doujinshi of the page of a given tag
  #
  # @param [String] keyword of the research
  # @param [Integer] sort optional, 1 is sorting by time, 2 is by popularity
  # @param [Integer] page each page can return 25 doujinshi
  # @return [Array] array of Info
  # @since 0.2.0
  #
  def self.listing(keyword, sort = 1, page = 1)
    keyword.tr!(' ', '-')
    sort = sort == 1 ? '' : 'popular'
    client = Net::HTTP.get_response(URI("https://nhentai.net/tag/#{keyword}/#{sort}?page=#{page}"))
    res = client.body.split(%r{<div class="gallery".+?>(.+)</div>}).select { |line| line.include?('<a href="/g/') }

    parse_tags(res)
  end

  #
  # @private
  #
  def self.parse_tags(res)
    res.map do |line|
      id    = line.match(%r{/g/(\d+)/})[1]
      name  = line.match(%r{<div class="caption">(.+)</div>})[1].strip
      count = 1
      url   = "/g/#{id}"

      Info.new(id, name, count, url)
    end
  end
end

class Parody < Tag
  #
  # List all doujinshi of the page of a given parody
  #
  # @since 0.2.0
  # @see Tag#listing
  #
  def self.listing(keyword, sort = 1, page = 1)
    keyword.tr!(' ', '-')
    sort = sort == 1 ? '' : 'popular'
    client = Net::HTTP.get_response(URI("https://nhentai.net/parody/#{keyword}/#{sort}?page=#{page}"))
    res = client.body.split(%r{<div class="gallery".+?>(.+)</div>}).select { |line| line.include?('<a href="/g/') }

    parse_tags(res)
  end
end

class Character < Tag
  #
  # List all doujinshi of the page of a given character
  #
  # @since 0.2.0
  # @see Tag#listing
  #
  def self.listing(keyword, sort = 1, page = 1)
    keyword.tr!(' ', '-')
    sort = sort == 1 ? '' : 'popular'
    client = Net::HTTP.get_response(URI("https://nhentai.net/character/#{keyword}/#{sort}?page=#{page}"))
    res = client.body.split(%r{<div class="gallery".+?>(.+)</div>}).select { |line| line.include?('<a href="/g/') }

    parse_tags(res)
  end
end

class Artist < Tag
  #
  # List all doujinshi of the page of a given artists
  #
  # @since 0.2.0
  # @see Tag#listing
  #
  def self.listing(keyword, sort = 1, page = 1)
    keyword.tr!(' ', '-')
    sort = sort == 1 ? '' : 'popular'
    client = Net::HTTP.get_response(URI("https://nhentai.net/artist/#{keyword}/#{sort}?page=#{page}"))
    res = client.body.split(%r{<div class="gallery".+?>(.+)</div>}).select { |line| line.include?('<a href="/g/') }

    parse_tags(res)
  end
end

class Group < Tag
  #
  # List all doujinshi of the page of a given group
  #
  # @since 0.2.0
  # @see Tag#listing
  #
  def self.listing(keyword, sort = 1, page = 1)
    keyword.tr!(' ', '-')
    sort = sort == 1 ? '' : 'popular'
    client = Net::HTTP.get_response(URI("https://nhentai.net/group/#{keyword}/#{sort}?page=#{page}"))
    res = client.body.split(%r{<div class="gallery".+?>(.+)</div>}).select { |line| line.include?('<a href="/g/') }

    parse_tags(res)
  end
end

class Language < Tag
  #
  # List all doujinshi of the page of a given language
  #
  # @since 0.2.0
  # @see Tag#listing
  #
  def self.listing(keyword, sort = 1, page = 1)
    keyword.tr!(' ', '-')
    sort = sort == 1 ? '' : 'popular'
    client = Net::HTTP.get_response(URI("https://nhentai.net/language/#{keyword}/#{sort}?page=#{page}"))
    res = client.body.split(%r{<div class="gallery".+?>(.+)</div>}).select { |line| line.include?('<a href="/g/') }

    parse_tags(res)
  end
end

class Category < Tag
  #
  # List all doujinshi of the page of a given category
  #
  # @since 0.2.0
  # @see Tag#listing
  #
  def self.listing(keyword, sort = 1, page = 1)
    keyword.tr!(' ', '-')
    sort = sort == 1 ? '' : 'popular'
    client = Net::HTTP.get_response(URI("https://nhentai.net/category/#{keyword}/#{sort}?page=#{page}"))
    res = client.body.split(%r{<div class="gallery".+?>(.+)</div>}).select { |line| line.include?('<a href="/g/') }

    parse_tags(res)
  end
end
