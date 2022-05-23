# frozen_string_literal: true

class Search
  def initialize(options:, sort: :none, page: 1)
    @options = options
    @client = Net::HTTP.get_response(URI("https://nhentai.net/api/galleries/search?query=#{string_options}&sort=#{SORT[sort]}&page=#{page}"))
    return unless exists?

    @response = JSON.parse(client.body)
  end

  def exists?
    client.code == '200'
  end

  def count
    response['result'].count
  end

  def num_pages
    response['num_pages']
  end

  def per_page
    response['per_page']
  end

  def listing
    response['result'].map { |doujin| Doujinshi.new(id: doujin) }
  end

  private

  attr_reader :options, :client, :response

  def string_options
    %i[keywords tags pages dates]
      .map { |symbol| send("parse_#{symbol}", options[symbol]) if options[symbol] }
      .join(' ')
  end

  def parse_pages(pages)
    pages.map { |page| "pages:#{page.tr(' ', '')}" }
  end

  def parse_dates(dates)
    dates.map { |date| "uploaded:#{date.tr(' ', '')}" }
  end

  def parse_tags(tags)
    ary = []

    %i[included excluded].each do |type|
      next if tags[type].nil?

      %i[tags parodies characters artists groups languages categories].each do |subtype|
        next if tags[type][subtype].empty? || tags[type][subtype].nil?

        ary <<
          tags[type][subtype]
            .map { |word| word.include?(' ') ? "\"#{word}\"" : word }
            .map { |word| word.prepend("#{subtype}:") }
            .map { |word| type == :excluded ? word.prepend('-') : word }
      end
    end

    ary
  end

  def parse_keywords(keywords)
    %i[included excluded].map do |type|
      next if keywords[type].nil?

      keywords[type]
        .map { |word| type == :excluded ? word.prepend('-') : word }
        .map { |word| word.include?(' ') ? "\"#{word}\"" : word }
    end
  end
end
