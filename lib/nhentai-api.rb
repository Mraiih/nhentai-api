# frozen_string_literal: true

%w[net/http ostruct time json].each { |e| require e }
%w[doujinshi search key].each { |e| require_relative e }

SORT = {
  today: 'popular-today',
  week: 'popular-week',
  all_time: 'popular'
}.freeze

def parse_tiles(res)
  res.map do |line|
    id    = line.match(%r{/g/(\d+)/})[1]
    name  = line.match(/<div class="caption">(.+)/)[1].strip
    url   = "/g/#{id}"

    OpenStruct.new(id: id, name: name, url: url)
  end
end
