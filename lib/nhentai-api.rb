require 'net/http'

class Tag
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
    @media_id     = @client.body.match(%r{\/([0-9]+)\/cover.jpg})[1]
    @count_pages  = @client.body.match(/([0-9]+) pages/)[1].to_i
  end

  def exists?
    @client.code == 200
  end

  def title
    @client.body.match(%r{<div id="info">\s+<h1>(.+)<\/h1>})[1]
  end

  def cover
    "https://t.nhentai.net/galleries/#{@media_id}/cover.jpg"
  end

  def page(page = 1)
    res = @client.body.match(%r{https://t.nhentai.net/galleries/#{@media_id}/#{page}t\.(.{3})"})

    "https://i.nhentai.net/galleries/#{@media_id}/#{page}.#{res[1]}"
  end

  def pages
    (1..@count_pages).map { |page| page(page) }
  end

  def thumbnail(page = 1)
    res = @client.body.match(%r{https://t.nhentai.net/galleries/#{@media_id}/(#{page}t\..{3})"})

    "https://t.nhentai.net/galleries/#{@media_id}/#{res[1]}"
  end

  def thumbnails
    (1..@count_pages).map { |page| thumbnail(page) }
  end

  def num_favorites
    regex = %r{<span>Favorite <span class="nobold">.(\d+).<\/span><\/span>}

    @client.body.match(regex)[1].to_i
  end

  def upload_date
    Time.parse(@client.body.match(/datetime="(.+)"/)[1])
  end

  def parse_tags(res)
    res.split(%r{<a(.+?)<\/a>}).reject(&:empty?).map do |line|
      id    = line.match(/tag-(\d+)/)[1]
      name  = line.match(/">(.+?)</)[1].strip
      count = line.match(/\((.+?)\)</)[1].tr(',', '').to_i
      url   = line.match(/href=\"(.+?)\"/)[1]

      Tag.new(id, name, count, url)
    end
  end

  def tags
    res = @client.body.match(%r{Tags:\s*<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  def count_tags
    res = @client.body.match(%r{Tags:\s*<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).count
  end

  def tags?
    !@client.body.match(%r{Tags:\s*<span class="tags">(.+)<\/span>}).nil?
  end

  def parodies
    res = @client.body.match(%r{Parodies:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  def count_parodies
    res = @client.body.match(%r{Parodies:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).count
  end

  def parodies?
    !@client.body.match(%r{Parodies:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  def characters
    res = @client.body.match(%r{Characters:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  def count_characters
    res = @client.body.match(%r{Characters:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).count
  end

  def characters?
    !@client.body.match(%r{Characters:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  def artists
    res = @client.body.match(%r{Artists:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  def count_artists
    res = @client.body.match(%r{Artists:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).count
  end

  def artists?
    !@client.body.match(%r{Artists:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  def groups
    res = @client.body.match(%r{Groups:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  def count_groups
    res = @client.body.match(%r{Groups:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).count
  end

  def groups?
    !@client.body.match(%r{Groups:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  def languages
    res = @client.body.match(%r{Languages:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  def count_languages
    res = @client.body.match(%r{Languages:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).count
  end

  def languages?
    !@client.body.match(%r{Languages:\s+<span class="tags">(.+)<\/span>}).nil?
  end

  def categories
    res = @client.body.match(%r{Categories:\s+<span class="tags">(.+)<\/span>})

    parse_tags(res[1])
  end

  def count_categories
    res = @client.body.match(%r{Categories:\s+<span class="tags">(.+)<\/span>})

    res.nil? ? 0 : parse_tags(res[1]).count
  end

  def categories?
    !@client.body.match(%r{Categories:\s+<span class="tags">(.+)<\/span>}).nil?
  end
end
