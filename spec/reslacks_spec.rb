require 'spec_helper'

RSpec.describe Reslacks do
  describe 'VERSION' do
    it 'has a version number' do
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
    let(:slack_client) { instance_double(Reslacks::Clients::Slack, deliver: true) }
    let(:web_token) { ENV['SLACK_WEB_HOOK'] }
    let(:options) do
      {
        color: %w[danger good warning info].sample,
        text: Faker::Hipster.paragraph.to_s,
        username: Faker::Company.name.to_s,
        footer: "#{Faker::Company.catch_phrase} | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}"
      }
    end

    before do
      Reslacks.configure do |config|
        config.slack_web_hook = web_token
      end

      allow(Reslacks::Clients::Slack).to receive(:new)
        .and_return(slack_client)
    end

    context 'when overriding base options' do
      let(:subject) { described_class.deliver(:basic, :info, options) }

      it 'passes args to slack client successfully' do
        subject
        expect(Reslacks::Clients::Slack).to have_received(:new)
          .with(web_token, options, :info, :basic)
      end
    end

    context 'when passed args are invalid' do
      let(:subject) { described_class.deliver('base', :success, {}) }

      it 'raises exception when msg_format is invalid' do
        expect { subject }.to raise_error(Reslacks::FormatError)
          .with_message('Invalid message_format type passed to as arg.')
      end
    end

    context 'when template arg is invalid' do
      let(:subject) { described_class.deliver(:basic, 0, {}) }

      it 'raises exception when template is invalid' do
        expect { subject }.to raise_error(Reslacks::FormatError)
          .with_message('Invalid template type passed to as arg.')
      end
    end

    context 'when options args are invalid' do
      let(:subject) { described_class.deliver(:basic, :info, '') }

      it 'raises exception when options is invalid' do
        expect { subject }.to raise_error(Reslacks::FormatError)
          .with_message('Invalid options passed as arg. Must be type of Hash.')
      end
    end

    context 'when passed args are nil' do
      let(:subject) { described_class.deliver(nil, nil, {}) }

      it 'should not raise error' do
        subject
        expect(Reslacks::Clients::Slack).to have_received(:new)
          .with(web_token, {}, nil, nil)
      end
    end
  end
end
