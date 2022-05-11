# frozen_string_literal: true

require 'nhentai-api'

RSpec.describe Artist do
  subject { described_class.listing(keyword, sort, page) }
  let(:keyword) { 'ogadenmon' }
  let(:sort) { 1 }
  let(:page) { 1 }

  describe '.listing' do
    it 'returns an OpenStruct' do
      expect(subject.first.class).to eq(OpenStruct)
    end

    context 'when the artist does not exist' do
      let(:keyword) { 'nopies' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when the search is sorted by popularity' do
      let(:sort) { 0 }

      it 'returns the most popular doujin' do
        expect(subject.first.name).to eq("[Illumination. (Ogadenmon)] Android no Ecchi na Yatsu | Horny Androids (NieR:Automata) [English] =TLL + mrwayne= [Digital]")
      end
    end
  end
end
