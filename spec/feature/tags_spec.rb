require_relative '../../nhentai-api'
require 'spec_helper'

book = Book.new(10)

RSpec.describe 'Basics:' do
  it 'should show the id' do
  expect(book.id).to eq 10
  end

  it 'should show the media id' do
    expect(book.media_id).to eq '806'
  end

  it 'should show the title' do
    expect(book.title).to eq '(C50) [H.P.C. Meirei Denpa (Yamamoto Yoshifumi)] Meirei Denpa Shinzou Teishi (Neon Genesis Evangelion) [Incomplete]'
  end

  it 'should show the numbers of pages' do
    expect(book.num_pages).to eq 32
  end

  it 'should show the numbers of favorites' do
    expect(book.num_favorites).to eq 35
  end

  it 'should show the upload date' do
    expect(book.upload_date.to_s).to eq '2014-06-28 14:12:18 +0000'
  end
end

RSpec.describe 'Tags Success:' do
  it 'should parse the id' do
    tag = book.tags[0]

    expect(tag.id).to eq '2937'
  end

  it 'should parse the name' do
    tag = book.tags[0]

    expect(tag.name).to eq 'big breasts'
  end

  it 'should parse the counter' do
    tag = book.tags[0]

    expect(tag.count).to eq 66_630
  end

  it 'should parse the URL' do
    tag = book.tags[0]

    expect(tag.url).to eq '/tag/big-breasts/'
  end
end

RSpec.describe 'Parodies:' do
  it 'should parse the id' do
    tag = book.parodies[0]

    expect(tag.id).to eq '17137'
  end

  it 'should parse the name' do
    tag = book.parodies[0]

    expect(tag.name).to eq 'neon genesis evangelion'
  end

  it 'should parse the counter' do
    tag = book.parodies[0]

    expect(tag.count).to eq 2_201
  end

  it 'should parse the URL' do
    tag = book.parodies[0]

    expect(tag.url).to eq '/parody/neon-genesis-evangelion/'
  end
end

RSpec.describe 'Characters:' do
  it 'should parse the id' do
  tag = book.characters[0]

  expect(tag.id).to eq '21779'
  end

  it 'should parse the name' do
    tag = book.characters[0]

    expect(tag.name).to eq 'rei ayanami'
  end

  it 'should parse the counter' do
    tag = book.characters[0]

    expect(tag.count).to eq 1_053
  end

  it 'should parse the URL' do
    tag = book.characters[0]

    expect(tag.url).to eq '/character/rei-ayanami/'
  end
end

RSpec.describe 'Artists:' do
  it 'should parse the id' do
  tag = book.artists[0]

  expect(tag.id).to eq '5960'
  end

  it 'should parse the name' do
    tag = book.artists[0]

    expect(tag.name).to eq 'yamamoto yoshifumi'
  end

  it 'should parse the counter' do
    tag = book.artists[0]

    expect(tag.count).to eq 165
  end

  it 'should parse the URL' do
    tag = book.artists[0]

    expect(tag.url).to eq '/artist/yamamoto-yoshifumi/'
  end
end

RSpec.describe 'Groups:' do
  it 'should parse the id' do
  tag = book.groups[0]

  expect(tag.id).to eq '14053'
  end

  it 'should parse the name' do
    tag = book.groups[0]

    expect(tag.name).to eq 'h.p.c. meirei denpa'
  end

  it 'should parse the counter' do
    tag = book.groups[0]

    expect(tag.count).to eq 2
  end

  it 'should parse the URL' do
    tag = book.groups[0]

    expect(tag.url).to eq '/group/h-p-c-meirei-denpa/'
  end
end

RSpec.describe 'Languages:' do
  it 'should parse the id' do
  tag = book.languages[0]

  expect(tag.id).to eq '6346'
  end

  it 'should parse the name' do
    tag = book.languages[0]

    expect(tag.name).to eq 'japanese'
  end

  it 'should parse the counter' do
    tag = book.languages[0]

    expect(tag.count).to eq 129_652
  end

  it 'should parse the URL' do
    tag = book.languages[0]

    expect(tag.url).to eq '/language/japanese/'
  end
end

RSpec.describe 'Categories:' do
  it 'should parse the id' do
  tag = book.categories[0]

  expect(tag.id).to eq '33172'
  end

  it 'should parse the name' do
    tag = book.categories[0]

    expect(tag.name).to eq 'doujinshi'
  end

  it 'should parse the counter' do
    tag = book.categories[0]

    expect(tag.count).to eq 138_514
  end

  it 'should parse the URL' do
    tag = book.categories[0]

    expect(tag.url).to eq '/category/doujinshi/'
  end
end
