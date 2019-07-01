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
    let(:subject) { described_class.deliver(:base, :info, options) }
    let(:slack_client) { instance_double(Reslacks::Clients::Slack, deliver: true) }
    let(:web_token) { ENV['SLACK_WEB_HOOK'] }

    before do
      Reslacks.configure do |config|
        config.slack_web_hook = web_token
      end
      allow(Reslacks::Clients::Slack).to receive(:new)
        .and_return(slack_client)

      subject
    end

    context 'when overriding base options' do
      let(:options) do
        {
          color: %w[danger good warning info].sample,
          text: Faker::Hipster.paragraph.to_s,
          username: Faker::Company.name.to_s,
          footer: "#{Faker::Company.catch_phrase} | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}"
        }
      end

      it 'passes args to slack client successfully' do
        expect(Reslacks::Clients::Slack).to have_received(:new)
          .with(web_token, options, :info, :base)
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
      let(:subject) { described_class.deliver(:base, 0, {}) }

      it 'raises exception when template is invalid' do
        expect { subject }.to raise_error(Reslacks::FormatError)
          .with_message('Invalid template type passed to as arg.')
      end
    end

    context 'when options args are invalid' do
      let(:subject) { described_class.deliver(:base, :info, '') }

      it 'raises exception when options is invalid' do
        expect { subject }.to raise_error(Reslacks::FormatError)
          .with_message('Invalid options passed as arg. Must be type of Hash.')
      end
    end

    context 'when some args are nil' do
      let(:subject) { described_class.deliver(nil, nil, {}) }

      it 'does nothing except and use default options' do
        expect(Reslacks::Clients::Slack).to have_received(:new)
          .with(web_token, options, :info, :base)
      end
    end
  end

  # xcontext 'testing deep_merge' do
  #   let(:options) do
  #     {
  #       text: 'Apple is coming for you motherf**ker',
  #       username: 'Joihn Delaney',
  #       color: '#7f0dc6',
  #       title: 'OH NO',
  #       author_name: 'Apple',
  #       icon_emoji: ":apple:"
  #     }
  #   end
  #
  #   before do
  #     Reslacks.configure do |config|
  #       config.slack_web_hook = ENV['SLACK_WEB_HOOK']
  #     end
  #   end
  #
  #   it 'should deliver the message' do
  #     Reslacks.deliver(options, :success)
  #   end
  # end
  #
  # context 'testing default states' do
  #   let(:options) do
  #     {
  #       text: 'I AM THE BBC!',
  #       username: 'John Delaney',
  #       color: '#2f7dc6',
  #       author_name: 'Slack Integration',
  #       icon_emoji: ":zipper_mouth_face:",
  #       channel: '#random'
  #     }
  #   end
  #
  #   before do
  #     Reslacks.configure do |config|
  #       config.slack_web_hook = ENV['SLACK_WEB_HOOK']
  #     end
  #   end
  #
  #   it 'should deliver the message' do
  #     Reslacks.deliver(:attachments, :success, options)
  #   end
  # end
  #
  # xcontext 'when a template is passed' do
  #   before do
  #     Reslacks.configure do |config|
  #       config.slack_web_hook = ENV['SLACK_WEB_HOOK']
  #     end
  #   end
  #
  #   xit 'should deliver a message with danger template' do
  #     Reslacks.deliver({ channel: '#general', text: 'Fuck' }, :danger)
  #   end
  #
  #   xit 'should deliver a message with success template' do
  #     Reslacks.deliver({ channel: '#general', text: 'Fuck' }, :success)
  #   end
  #
  #   xit 'should deliver a message with info template' do
  #     Reslacks.deliver({}, :info)
  #   end
  #
  #   xit 'should deliver a message with warning template' do
  #     Reslacks.deliver({}, :warning)
  #   end
  # end
end
