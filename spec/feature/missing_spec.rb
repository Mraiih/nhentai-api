require 'nhentai-api'
require 'spec_helper'

book = Doujinshi.new(11)

RSpec.describe 'Missing:' do
  it 'should not return parodies' do
    expect(book.parodies?).to eq false
  end

  it 'should not count parodies' do
    expect(book.count_parodies).to eq 0
  end

  it 'should not return characters' do
    expect(book.characters?).to eq false
  end

  it 'should not count characters' do
    expect(book.count_characters).to eq 0
  end

  it 'should not return groups' do
    expect(book.groups?).to eq false
  end

  it 'should not count groups' do
    expect(book.count_groups).to eq 0
  end
end
