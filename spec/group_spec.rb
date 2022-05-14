# frozen_string_literal: true

require 'nhentai-api'

RSpec.describe Group do
  let(:keyword) { 'illumination' }
  let(:sort) { 1 }
  let(:page) { 1 }

  describe '.count' do
    subject { described_class.count(keyword) }

    it "returns a number" do
      expect(subject).to be_a(Integer)
    end

    context 'when the group does not exist' do
      let(:keyword) { 'nopies' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '.listing' do
    subject { described_class.listing(keyword, sort, page) }

    it 'returns an OpenStruct' do
      expect(subject.first.class).to eq(OpenStruct)
    end

    context 'when the group does not exist' do
      let(:keyword) { 'nopies' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when the search is sorted by popularity' do
      let(:sort) { 0 }

      it 'returns the most popular doujin' do
        expect(subject.first.name).to eq('[Illumination. (Ogadenmon)] Android no Ecchi na Yatsu | Horny Androids (NieR:Automata) [English] =TLL + mrwayne= [Digital]')
      end
    end
  end
end
