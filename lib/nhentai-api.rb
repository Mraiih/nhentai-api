# frozen_string_literal: true

%w[net/http ostruct time json].each { |e| require e }
%w[doujinshi search key].each { |e| require_relative e }

SORT = {
  today: 'popular-today',
  week: 'popular-week',
  all_time: 'popular'
}.freeze
