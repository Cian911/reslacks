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
    context 'when overriding base options' do
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
          config.slack_web_hook = ENV['SLACK_WEB_HOOK']
        end
      end

      xit 'should deliver the message' do
        Reslacks.deliver(options, :success)
      end
    end
  end

  xcontext 'testing deep_merge' do
    let(:options) do
      {
        text: 'Apple is coming for you motherf**ker',
        username: 'Joihn Delaney',
        color: '#7f0dc6',
        title: 'OH NO',
        author_name: 'Apple',
        icon_emoji: ":apple:"
      }
    end

    before do
      Reslacks.configure do |config|
        config.slack_web_hook = ENV['SLACK_WEB_HOOK']
      end
    end

    it 'should deliver the message' do
      Reslacks.deliver(options, :success)
    end
  end

  context 'testing default states' do
    let(:options) do
      {
        text: 'I AM THE BBC!',
        username: 'John Delaney',
        color: '#2f7dc6',
        author_name: 'Slack Integration',
        icon_emoji: ":zipper_mouth_face:",
        channel: '#general'
      }
    end

    before do
      Reslacks.configure do |config|
        config.slack_web_hook = ENV['SLACK_WEB_HOOK']
      end
    end

    it 'should deliver the message' do
      Reslacks.deliver(:attachments, :success, options)
    end
  end

  xcontext 'when a template is passed' do
    before do
      Reslacks.configure do |config|
        config.slack_web_hook = ENV['SLACK_WEB_HOOK']
      end
    end

    xit 'should deliver a message with danger template' do
      Reslacks.deliver({ channel: '#general', text: 'Fuck' }, :danger)
    end

    xit 'should deliver a message with success template' do
      Reslacks.deliver({ channel: '#general', text: 'Fuck' }, :success)
    end

    xit 'should deliver a message with info template' do
      Reslacks.deliver({}, :info)
    end

    xit 'should deliver a message with warning template' do
      Reslacks.deliver({}, :warning)
    end
  end
end
