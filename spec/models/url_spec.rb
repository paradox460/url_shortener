require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:url) { create(:url) }
  describe '.decode' do
    context 'with a nonexistent hash' do
      it { expect { Url.decode('abc') }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'with an invalid hash' do
      it { expect { Url.decode('!#$%') }.to raise_error(ArgumentError, 'hash must be valid Base36') }
    end

    context 'with a hash that exists' do
      let(:decoded_url) { Url.decode(url.shortcode) }
      it { expect(decoded_url).to be_a(Url) }
      it { expect(decoded_url).to eql(url) }
    end
  end

  describe '#shortcode' do
    context 'when unsaved' do
      it { expect(build(:url).shortcode).to be_nil }
    end

    context 'when persisted to a db' do
      it { expect(url.shortcode).to be_a(String) }
      it { expect(url.shortcode).to match(/[[:alnum:]]+/) }
    end
  end

  describe '#to_param' do
    it do
      expect(url).to receive(:shortcode)
      url.to_param
    end
  end

  describe '#url' do
    context 'with an invalid url' do
      let(:bad_url) { build(:url, url: 'ajksdfh') }
      it { expect { bad_url.save! }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Url only accepts a valid URI') }
    end
    context 'with a valid url' do
      it 'should generate salts before create' do
        url = build(:url)
        expect(url.salt).to be_nil
        url.save
        expect(url.salt).to be_a(Fixnum)
      end

      it 'should not change a salt on save' do
        salt = url.salt
        url.touch
        url.save
        expect(url.salt).to eql(salt)
      end
    end
  end

  describe '#generate_salt' do
    it do
      expect(url).to receive(:rand).with(8).exactly(3).times.and_call_original
      url.send(:generate_salt)
    end
  end
end
