# frozen_string_literal: true

require 'nhentai-api'

RSpec.describe Doujinshi do
  subject(:doujin) { described_class.new(id: id) }
  let!(:id) { 220_794 }

  describe '.random' do
    it 'returns an Doujin' do
      expect(described_class.random).to be_a(Doujinshi)
    end
  end

  describe '#exists?' do
    it 'returns true' do
      expect(doujin.exists?).to be(true)
    end

    context 'when the doujinshi does not exist' do
      let(:id) { -1 }

      it 'returns false' do
        expect(doujin.exists?).to be(false)
      end
    end
  end

  describe '#media_id' do
    it 'returns the media_id' do
      expect(doujin.media_id).to eq("1170172")
    end
  end

  describe '#num_pages' do
    it 'returns the number of pages' do
      expect(doujin.num_pages).to eq(31)
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(doujin.title).to eq('Android no Ecchi na Yatsu | Horny Androids')
    end

    context 'when we ask for another type of title' do
      it 'returns the title' do
        expect(doujin.title(type: :english)).to eq('[Illumination. (Ogadenmon)] Android no Ecchi na Yatsu | Horny Androids (NieR:Automata) [English] =TLL + mrwayne= [Digital]')
      end
    end
  end

  describe '#cover' do
    it 'returns the cover' do
      expect(doujin.cover).to include('/galleries/1170172/cover.jpg')
    end

    context 'when the cover is a png' do
      let(:id) { 226_804 }

      it 'returns the cover' do
        expect(doujin.cover).to include('/galleries/1195682/cover.png')
      end
    end
  end

  describe '#page' do
    it 'returns the page' do
      expect(doujin.page).to include('/galleries/1170172/1.jpg')
    end

    context 'when we give a specific page' do
      it 'returns the correct page' do
        expect(doujin.page(page: 5)).to include('/galleries/1170172/5.png')
      end
    end
  end

  describe '#pages' do
    it 'returns pages' do
      expect(doujin.pages).to include('https://i.nhentai.net/galleries/1170172/31.png')
    end

    it 'returns all the pages' do
      expect(doujin.pages.count).to eq(31)
    end
  end

  describe '#thumbnail' do
    it 'returns the thumbnail' do
      expect(doujin.thumbnail).to include('/galleries/1170172/1t.jpg')
    end

    context 'when we give a specific thumbnail' do
      it 'returns the correct thumbnail' do
        expect(doujin.thumbnail(page: 5)).to include('/galleries/1170172/5t.png')
      end
    end
  end

  describe '#thumbnails' do
    it 'returns thumbnails' do
      expect(doujin.thumbnails).to include('https://t.nhentai.net/galleries/1170172/31t.png')
    end

    it 'returns all the thumbnails' do
      expect(doujin.thumbnails.count).to eq(31)
    end
  end

  describe '#count_favorites' do
    it 'returns an Integer' do
      expect(doujin.count_favorites).to be_a(Integer)
    end
  end

  describe '#upload_date' do
    it 'returns the date of upload' do
      expect(doujin.upload_date).to eq(Time.parse('2018-01-17 15:56:16 UTC'))
    end
  end

  describe '#tags' do
    it 'returns the list of tags' do
      tag = OpenStruct.new(id: 35_762, name: 'sole female', count: 0, url: '/tag/sole-female/')

      expect(doujin.tags.each { |tag| tag.count = 0 }).to include(tag)
    end

    context 'when the doujin does not have any tag' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns an empty list' do
        expect(doujin.tags).to eq([])
      end
    end
  end

  describe '#count_tags' do
    it 'returns the number of tags' do
      expect(doujin.count_tags).to eq(9)
    end
  end

  describe '#tags?' do
    it 'returns true' do
      expect(doujin.tags?).to be(true)
    end

    context 'when the doujin does not have any tag' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns false' do
        expect(doujin.tags?).to be(false)
      end
    end
  end

  describe '#parodies' do
    it 'returns the list of parodies' do
      parody = OpenStruct.new(id: 73_370, name: 'nier automata', count: 0, url: '/parody/nier-automata/')

      expect(doujin.parodies.each { |tag| tag.count = 0 }).to include(parody)
    end

    context 'when the doujin does not have any parody' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns an empty list' do
        expect(doujin.parodies).to eq([])
      end
    end
  end

  describe '#count_parodies' do
    it 'returns the number of parodies' do
      expect(doujin.count_parodies).to eq(1)
    end
  end

  describe '#parodies?' do
    it 'returns true' do
      expect(doujin.parodies?).to be(true)
    end

    context 'when the doujin does not have any parody' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns false' do
        expect(doujin.parodies?).to be(false)
      end
    end
  end

  describe '#characters' do
    it 'returns the list of characters' do
      character = OpenStruct.new(id: 71_544, name: '2b', count: 0, url: '/character/2b/')

      expect(doujin.characters.each { |tag| tag.count = 0 }).to include(character)
    end

    context 'when the doujin does not have any character' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns an empty list' do
        expect(doujin.characters).to eq([])
      end
    end
  end

  describe '#count_characters' do
    it 'returns the number of characters' do
      expect(doujin.count_characters).to eq(2)
    end
  end

  describe '#characters?' do
    it 'returns true' do
      expect(doujin.characters?).to be(true)
    end

    context 'when the doujin does not have any character' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns false' do
        expect(doujin.characters?).to be(false)
      end
    end
  end

  describe '#artists' do
    it 'returns the list of artists' do
      artist = OpenStruct.new(id: 10_644, name: 'ogadenmon', count: 0, url: '/artist/ogadenmon/')

      expect(doujin.artists.each { |tag| tag.count = 0 }).to include(artist)
    end

    context 'when the doujin does not have any artist' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns an empty list' do
        expect(doujin.artists).to eq([])
      end
    end
  end

  describe '#count_artists' do
    it 'returns the number of artists' do
      expect(doujin.count_artists).to eq(1)
    end
  end

  describe '#artists?' do
    it 'returns true' do
      expect(doujin.artists?).to be(true)
    end

    context 'when the doujin does not have any artist' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns false' do
        expect(doujin.artists?).to be(false)
      end
    end
  end

  describe '#groups' do
    it 'returns the list of groups' do
      group = OpenStruct.new(id: 35_330, name: 'illumination.', count: 0, url: '/group/illumination/')

      expect(doujin.groups.each { |tag| tag.count = 0 }).to include(group)
    end

    context 'when the doujin does not have any group' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns an empty list' do
        expect(doujin.groups).to eq([])
      end
    end
  end

  describe '#count_groups' do
    it 'returns the number of groups' do
      expect(doujin.count_groups).to eq(1)
    end
  end

  describe '#groups?' do
    it 'returns true' do
      expect(doujin.groups?).to be(true)
    end

    context 'when the doujin does not have any group' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns false' do
        expect(doujin.groups?).to be(false)
      end
    end
  end

  describe '#languages' do
    it 'returns the list of languages' do
      language = OpenStruct.new(id: 12_227, name: 'english', count: 0, url: '/language/english/')

      expect(doujin.languages.each { |tag| tag.count = 0 }).to include(language)
    end

    context 'when the doujin does not have any language' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns an empty list' do
        expect(doujin.languages).to eq([])
      end
    end
  end

  describe '#count_languages' do
    it 'returns the number of languages' do
      expect(doujin.count_languages).to eq(2)
    end
  end

  describe '#languages?' do
    it 'returns true' do
      expect(doujin.languages?).to be(true)
    end

    context 'when the doujin does not have any language' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns false' do
        expect(doujin.languages?).to be(false)
      end
    end
  end

  describe '#categories' do
    it 'returns the list of categories' do
      category = OpenStruct.new(id: 33_172, name: 'doujinshi', count: 0, url: '/category/doujinshi/')

      expect(doujin.categories.each { |tag| tag.count = 0 }).to include(category)
    end

    context 'when the doujin does not have any category' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns an empty list' do
        expect(doujin.categories).to eq([])
      end
    end
  end

  describe '#count_categories' do
    it 'returns the number of categories' do
      expect(doujin.count_categories).to eq(1)
    end
  end

  describe '#categories?' do
    it 'returns true' do
      expect(doujin.categories?).to be(true)
    end

    context 'when the doujin does not have any category' do
      before { allow(doujin).to receive(:response).and_return({ 'tags' => [] }) }

      it 'returns false' do
        expect(doujin.categories?).to be(false)
      end
    end
  end
end
