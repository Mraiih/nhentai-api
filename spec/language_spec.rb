# frozen_string_literal: true

require 'nhentai-api'

RSpec.describe Language do
  let(:keyword) { 'english' }
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

    context 'when the language does not exist' do
      let(:keyword) { 'nopies' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when the search is sorted by popularity' do
      let(:sort) { 0 }

      it 'returns the most popular doujin' do
        expect(subject.first.name).to eq('[Puu no Puupuupuu (Puuzaki Puuna)] Hitozukiai ga Nigate na Miboujin no Yukionna-san to Noroi no Yubiwa [English]')
      end
    end
  end
end
