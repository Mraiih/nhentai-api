# frozen_string_literal: true

class Search
  attr_reader :options, :client

  def initialize(options:, sort: :none, page: 1)
    @options = options
    @client = Net::HTTP.get_response(URI("https://nhentai.net/search/?q=#{string_options}&sort=#{SORT[sort]}&page=#{page}"))
  end

  def exists?
    client.code == '200'
  end

  def count
    client.body.match(%r{<h1>.*<\/i>(.*) results<\/h1>})[1]
      .tr(',', '')
      .to_i
  end

  def listing
    res = client.body.split(%r{<div class="gallery".+?>(.*?)<\/div>}).select { |line| line.include?('<a href="/g/') }
    parse_search(res)
  end

  private

  def string_options
    %i[keywords tags pages dates]
      .map { |symbol| send("parse_#{symbol}", options[symbol]) if options[symbol] }
      .join(' ')
  end

  def parse_search(res)
    res.map do |line|
      id    = line.match(%r{/g/(\d+)/})[1]
      name  = line.match(/<div class="caption">(.+)/)[1].strip
      url   = "/g/#{id}"

      OpenStruct.new(id: id, name: name, url: url)
    end
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
