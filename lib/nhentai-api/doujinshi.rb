# frozen_string_literal: true

class Doujinshi
  def initialize(id:)
    case id
    when Integer, String
      @id     = id
      @client = Net::HTTP.get_response(URI("https://nhentai.net/api/gallery/#{id}"))
      return unless exists?

      @response = JSON.parse(client.body)
    when Hash
      @response = id
    end
  end

  def self.random
    fetch('https://nhentai.net/random')
  end

  def exists?
    client.code == '200'
  end

  def media_id
    response['media_id']
  end

  def num_pages
    response['num_pages']
  end

  def title(type: :pretty)
    response['title'][type.to_s]
  end

  def cover
    "https://t.nhentai.net/galleries/#{media_id}/cover.#{IMAGE_EXTENSION[response['images']['cover']['t']]}"
  end

  def page(page: 1)
    "https://i.nhentai.net/galleries/#{media_id}/#{page}.#{IMAGE_EXTENSION[response['images']['pages'][page - 1]['t']]}"
  end

  def pages
    (1..num_pages).map { |page| page(page: page) }
  end

  def thumbnail(page: 1)
    "https://t.nhentai.net/galleries/#{media_id}/#{page}t.#{IMAGE_EXTENSION[response['images']['pages'][page - 1]['t']]}"
  end

  def thumbnails
    (1..num_pages).map { |page| thumbnail(page: page) }
  end

  def count_favorites
    response['num_favorites']
  end

  def upload_date
    Time.at(response['upload_date']).utc
  end

  %w[tags parodies characters artists groups languages categories].each do |method|
    define_method method do
      return instance_variable_get("@#{method}") if instance_variable_defined?("@#{method}")

      res = response['tags'].select { |tag| tag['type'] == SINGULAR_TAG[method] }
      instance_variable_set("@#{method}", parsing_informations(res))
    end

    define_method "count_#{method}" do
      send(method).size
    end

    define_method "#{method}?" do
      !send(method).empty?
    end
  end

  def related
    client    = Net::HTTP.get_response(URI("https://nhentai.net/api/gallery/#{id}/related"))
    response  = JSON.parse(client.body)

    response['result'].map { |doujin| Doujinshi.new(id: doujin) }
  end

  private

  attr_reader :client, :response, :id

  def parsing_informations(res)
    res.map do |line|
      OpenStruct.new(
        id: line['id'],
        name: line['name'],
        count: line['count'],
        url: line['url']
      )
    end
  end

  def self.fetch(uri_str)
    client = Net::HTTP.get_response(URI(uri_str))

    case client
    when Net::HTTPFound then new(id: client['location'][3..-2])
    when Net::HTTPRedirection then fetch("https://nhentai.net#{client['location']}")
    end
  end
end
