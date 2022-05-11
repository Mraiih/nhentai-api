require "net/http"
require "ostruct"
require "time"
require "json"

class Doujinshi
  attr_reader :id, :client, :media_id, :count_pages, :response

  def initialize(id)
    @id           = id
    @client       = Net::HTTP.get_response(URI("https://nhentai.net/g/#{@id}/"))
    return unless exists?

    @media_id     = @client.body.match(%r{\/([0-9]+)\/cover})[1]
    @count_pages  = @client.body.match(/Pages:\s*.*>([0-9]+)</)[1].to_i
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
    client.code == '200'
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
    @client.body.match(/"pretty">(.*?)</)[1]
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
  #   doujinshi.page        #=> 'https://i.nhentai.net/galleries/1170172/1.jpg'
  #   doujinshi.page(10)    #=> 'https://i.nhentai.net/galleries/1170172/10.jpg'
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
    (1..count_pages).map { |page| page(page) }
  end

  #
  # Give the thumbnail's URL of a given page of a doujinshi
  #
  # @param [Integer] page a particular page of a doujinshi
  # @return [String] the thumbnail's URL of a given page of a doujinshi
  # @since 0.1.0
  # @example
  #   doujinshi.thumbnail       #=> 'https://t.nhentai.net/galleries/1170172/1t.jpg'
  #   doujinshi.thumbnail(10)   #=> 'https://t.nhentai.net/galleries/1170172/10t.jpg'
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
  #   doujinshi.count_favorites   #=> 13326
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
    Time.iso8601(@client.body.match(/<time .+ datetime="(.*?)"/)[1])
  end

  #
  # Give all tags of a doujinshi
  #
  # @return [Array] of Tag class of a given doujinshi
  # @since 0.1.0
  # @example
  #   doujinshi.tags
  #

  #
  # Give a counter of tags
  #
  # @return [Integer] of tags
  # @since 0.1.0
  # @example
  #   doujinshi.count_tags    #=> 9
  #

  #
  # Check if a particular doujinshi have some tags
  #
  # @return [Bool] true if the doujinshi have tags, otherwise false
  # @since 0.1.0
  # @example
  #   doujinshi.tags?   #=> true
  #

  #
  # Give all parodies of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #

  #
  # Give a counter of parodies
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #

  #
  # Check if a particular doujinshi have some parodies
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #

  #
  # Give all characters of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #

  #
  # Give a counter of characters
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #

  #
  # Check if a particular doujinshi have some characters
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #

  #
  # Give all artists of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #

  #
  # Give a counter of artists
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #

  #
  # Check if a particular doujinshi have some artists
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #

  #
  # Give all groups of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #

  #
  # Give a counter of groups
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #

  #
  # Check if a particular doujinshi have some groups
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #

  #
  # Give all languages of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #

  #
  # Give a counter of languages
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #

  #
  # Check if a particular doujinshi have some languages
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #

  #
  # Give all categories of a doujinshi
  #
  # @since 0.1.0
  # @see Doujinshi#tags
  #

  #
  # Give a counter of categories
  #
  # @since 0.1.0
  # @see Doujinshi#count_tags
  #

  #
  # Check if a particular doujinshi have some categories
  #
  # @since 0.1.0
  # @see Doujinshi#tags?
  #

  %w[tags parodies characters artists groups languages categories].each do |method|
    define_method method do
      return instance_variable_get("@#{method}") if instance_variable_defined?("@#{method}")

      res = @client.body.match(%r{#{method.capitalize}:\s*<span class="tags">(.+)<\/span>})
      return [] if res.nil?

      instance_variable_set("@#{method}", parse_tags(res[1]))
    end

    define_method "count_#{method}" do
      send(method).size
    end

    define_method "#{method}?" do
      !send(method).empty?
    end
  end

  #
  # @private
  #

  private

  def parse_tags(res)
    res.split(%r{<a(.+?)<\/a>}).reject(&:empty?).map do |line|
      id    = line.match(/tag-(\d+)/)[1]
      name  = line.match(/class="name">(.+?)</)[1].strip
      count = line.match(/class="count">(\d+.)</)[1]
      url   = line.match(/href=\"(.+?)\"/)[1]

      count = count[-1] == 'K' ? count.to_i * 1000 : count.to_i

      OpenStruct.new(id: id, name: name, count: count, url: url)
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

      OpenStruct.new(id: id, name: name, count: count, url: url)
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
