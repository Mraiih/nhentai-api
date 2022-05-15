# frozen_string_literal: true

%w[tag parody character artist group language category].each do |class_name|
  c = Class.new do
    def self.count(keyword)
      keyword     = keyword.tr(' ', '-')
      @client     = Net::HTTP.get_response(URI("https://nhentai.net/#{class_name}/#{keyword}/"))
      return unless exists?

      count = @client.body.match(%r{<a.*class="count">(.*)<\/span><\/a>})[1]
      count[-1] == 'K' ? count.to_i * 1000 : count.to_i
    end

    def self.listing(keyword, sort = 1, page = 1)
      @client = Net::HTTP.get_response(URI("https://nhentai.net/#{class_name}/#{keyword.tr(' ', '-')}/#{sort_method(sort)}?page=#{page}"))
      return unless exists?

      res = @client.body.split(%r{<div class="gallery".+?>(.*?)<\/div>}).select { |line| line.include?('<a href="/g/') }
      parse_tags(res)
    end

    private

    def self.class_name
      name.split('::').last.downcase
    end

    def self.sort_method(sort)
      sort == 1 ? '' : 'popular'
    end

    def self.exists?
      @client.code == '200'
    end

    def self.parse_tags(res)
      res.map do |line|
        id    = line.match(%r{/g/(\d+)/})[1]
        name  = line.match(/<div class="caption">(.+)/)[1].strip
        url   = "/g/#{id}"

        OpenStruct.new(id: id, name: name, url: url)
      end
    end
  end

  Kernel.const_set(class_name.capitalize, c)
end
