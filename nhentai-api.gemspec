# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name                  = 'nhentai-api'
  s.version               = '1.0.1'
  s.date                  = '2022-05-21'
  s.summary               = 'nhentai-api is a basic and easy to use API for nhentai.net'
  s.description           = 'nhentai-api is a basic and easy to use API for nhentai.net'
  s.authors               = ['Gael Roussel']
  s.email                 = 'gaelroussel@protonmail.com'
  s.files                 = [
    'lib/nhentai-api.rb',
    'lib/nhentai-api/doujinshi.rb',
    'lib/nhentai-api/key.rb',
    'lib/nhentai-api/search.rb'
  ]
  s.homepage              = 'https://rubygems.org/gems/nhentai-api'
  s.license               = 'MIT'
  s.require_paths         = ['lib']
  s.metadata              = {
    'source_code_uri'   => 'https://github.com/Mraiih/nhentai-api',
    'changelog_uri'     => 'https://github.com/Mraiih/nhentai-api/blob/master/CHANGELOG.md',
    'documentation_uri' => 'https://github.com/Mraiih/nhentai-api/wiki/Documentation',
    'funding_uri'       => 'https://ko-fi.com/mraiih'
  }
end
