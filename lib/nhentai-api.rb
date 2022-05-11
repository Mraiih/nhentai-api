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

  def exists?
    client.code == '200'
  end

  def title
    @client.body.match(/"pretty">(.*?)</)[1]
  end

  def cover
    res = @client.body.match(%r{https://t.nhentai.net/galleries/#{@media_id}/cover\.(.{3})"})

    "https://t.nhentai.net/galleries/#{@media_id}/cover.#{res[1]}"
  end

  def page(page = 1)
    res = @client.body.match(%r{https://t.nhentai.net/galleries/#{@media_id}/#{page}t\.(.{3})"})

    "https://i.nhentai.net/galleries/#{@media_id}/#{page}.#{res[1]}"
  end

  def pages
    (1..count_pages).map { |page| page(page) }
  end

  def thumbnail(page = 1)
    res = @client.body.match(%r{https://t.nhentai.net/galleries/#{@media_id}/(#{page}t\..{3})"})

    "https://t.nhentai.net/galleries/#{@media_id}/#{res[1]}"
  end

  def thumbnails
    (1..@count_pages).map { |page| thumbnail(page) }
  end

  def count_favorites
    regex = %r{<span>Favorite <span class="nobold">.(\d+).<\/span><\/span>}

    @client.body.match(regex)[1].to_i
  end

  def upload_date
    Time.iso8601(@client.body.match(/<time .+ datetime="(.*?)"/)[1])
  end

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

%w[tag parody character artist group language category].each do |class_name|
  c = Class.new do

    def self.listing(keyword, sort = 1, page = 1)
      class_name  = name.split('::').last.downcase
      keyword     = keyword.tr(' ', '-')
      sort        = sort == 1 ? '' : 'popular'
      @client     = Net::HTTP.get_response(URI("https://nhentai.net/#{class_name}/#{keyword}/#{sort}?page=#{page}"))
      return unless exists?

      res = @client.body.split(%r{<div class="gallery".+?>(.*?)<\/div>}).select { |line| line.include?('<a href="/g/') }

      parse_tags(res)
    end

    private

    def self.exists?
      @client.code == '200'
    end

    def self.parse_tags(res)
      res.map do |line|
        id    = line.match(%r{/g/(\d+)/})[1]
        name  = line.match(%r{<div class="caption">(.+)})[1].strip
        count = 1
        url   = "/g/#{id}"

        OpenStruct.new(id: id, name: name, count: count, url: url)
      end
    end
  end

  Kernel.const_set(class_name.capitalize, c)
end
