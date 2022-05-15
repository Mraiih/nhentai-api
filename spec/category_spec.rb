# frozen_string_literal: true

require 'nhentai-api'

RSpec.describe Category do
  subject { described_class.new(keyword: keyword, sort: sort, page: page) }
  let(:keyword) { 'doujinshi' }
  let(:sort) { :none }
  let(:page) { 1 }

  describe '#count' do
    it "returns a number" do
      expect(subject.count).to be_a(Integer)
    end

    context 'when the group does not exist' do
      let(:keyword) { 'nopies' }

      it 'returns 0' do
        expect(subject.count).to eq(0)
      end
    end
  end

  describe '#listing' do
    it 'returns an OpenStruct' do
      expect(subject.listing.first.class).to eq(OpenStruct)
    end

    context 'when the category does not exist' do
      let(:keyword) { 'nopies' }

      it 'returns an empty array' do
        expect(subject.listing).to eq([])
      end
    end

    context 'when the search is sorted by popularity' do
      let(:sort) { :all_time }

      it 'returns the most popular doujin' do
        expect(subject.listing.first.name).to eq('[Puu no Puupuupuu (Puuzaki Puuna)] Hitozukiai ga Nigate na Miboujin no Yukionna-san to Noroi no Yubiwa [English]')
      end
    end
  end
end
