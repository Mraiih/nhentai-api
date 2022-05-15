# frozen_string_literal: true

%w[tag parody character artist group language category].each do |class_name|
  c = Class.new do
    attr_reader :client

    def initialize(keyword:, sort: :none, page: 1)
      @client = Net::HTTP.get_response(URI("https://nhentai.net/#{class_name}/#{keyword.tr(' ', '-')}/#{SORT[sort]}?page=#{page}"))
    end

    def count
      res = client.body.match(%r{<a.*class="count">(.*)<\/span><\/a>})
      return 0 if res.nil?

      count = res[1]
      count[-1] == 'K' ? count.to_i * 1000 : count.to_i
    end

    def listing
      res = client.body.split(%r{<div class="gallery".+?>(.*?)<\/div>}).select { |line| line.include?('<a href="/g/') }
      parse_tiles(res)
    end

    def exists?
      @client.code == '200'
    end

    private

    def class_name
      self.class.name.split('::').last.downcase
    end
  end

  Kernel.const_set(class_name.capitalize, c)
end
