require 'spec_helper'

RSpec.describe Reslacks do
  describe 'VERSION' do
    it "has a version number" do
      expect(Reslacks::VERSION).not_to be nil
    end
  end

  describe '.config' do
    context 'when a block is passed' do
      before do
        Reslacks.configure do |config|
          config.slack_web_hook = 'dcba'
        end
      end

      it 'yields the block as default' do
        expect(Reslacks.config.slack_web_hook).to eq('dcba')
      end

      after do
        Reslacks.reset
      end
    end

    context 'when no block is passed' do
      it 'config should be nil' do
        expect(Reslacks.config.slack_web_hook).to be_nil
      end
    end
  end

  describe '.deliver' do
    let(:options) do
      {
        text: "This is a test",
        channel: "#programming",
        color: "danger"
      }
    end

    before do
      Reslacks.configure do |config|
        config.slack_web_hook = ''
      end
    end

    it 'should deliver the message' do
      Reslacks.deliver(options)
    end
  end
end
