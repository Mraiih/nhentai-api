# frozen_string_literal: true

require 'nhentai-api'

RSpec.describe Category do
  subject { described_class.listing(keyword, sort, page) }
  let(:keyword) { 'doujinshi' }
  let(:sort) { 1 }
  let(:page) { 1 }

  describe '.listing' do
    it 'returns an OpenStruct' do
      expect(subject.first.class).to eq(OpenStruct)
    end

    context 'when the category does not exist' do
      let(:keyword) { 'nopies' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when the search is sorted by popularity' do
      let(:sort) { 0 }

      it 'returns the most popular doujin' do
        expect(subject.first.name).to eq("[Puu no Puupuupuu (Puuzaki Puuna)] Hitozukiai ga Nigate na Miboujin no Yukionna-san to Noroi no Yubiwa [English]")
      end
    end
  end
end
