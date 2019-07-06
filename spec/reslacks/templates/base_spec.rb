require 'spec_helper'

RSpec.describe Reslacks::Templates::Base do
  let(:subject) { described_class.new(options = {}, template = nil) }
  let(:expected_message) do
    {
      attachments: {
        author_icon: 'https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png',
        author_link: 'https://github.com/Cian911/reslacks',
        author_name: 'Reslacks',
        color: '#A0A0A0',
        fields: [{ short: false, title: 'Medium', value: 'Priority' }],
        footer: "Reslacks #0.1.0 | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}",
        mrkdwn: true,
        mrkdwn_in: ['text'],
        sub_field: '[Reslacks](https://github.com/Cian911/reslacks) - 0.1.0',
        title: 'Notification',
        title_link: ''
      },
      channel: '',
      icon_emoji: ':100:',
      text: 'Reslacks test integration is working. Please override this value with your desired value.',
      username: '[Reslacks](https://github.com/Cian911/reslacks) - 0.1.0'
    }
  end

  before do
    Timecop.freeze(Time.now)
  end

  describe '.message' do
    context 'when no options and no template are passed' do
      it 'builds a default base template' do
        expect(subject.message).to eq(expected_message)
      end
    end

    context 'when success template is passed' do
      let(:subject) { described_class.new({}, :success) }

      before do
        expected_message[:attachments] = { author_icon: 'https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png', author_link: 'https://github.com/Cian911/reslacks', author_name: 'Reslacks', color: '#64BF2A', fields: [{ short: false, title: 'Medium', value: 'Priority' }], footer: "Reslacks #0.1.0 | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}", mrkdwn: true, mrkdwn_in: ['text'], sub_field: '[Reslacks](https://github.com/Cian911/reslacks) - 0.1.0', title: 'Notification', title_link: '' }
      end

      it 'uses default success template' do
        expect(subject.message).to eq(expected_message)
      end
    end

    context 'when warning template is passed' do
      let(:subject) { described_class.new({}, :warning) }

      before do
        expected_message[:attachments] = { author_icon: 'https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png', author_link: 'https://github.com/Cian911/reslacks', author_name: 'Reslacks', color: '#D5C30A', fields: [{ short: false, title: 'Medium', value: 'Priority' }], footer: "Reslacks #0.1.0 | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}", mrkdwn: true, mrkdwn_in: ['text'], sub_field: '[Reslacks](https://github.com/Cian911/reslacks) - 0.1.0', title: 'Notification', title_link: '' }
      end

      it 'uses default warning template' do
        expect(subject.message).to eq(expected_message)
      end
    end

    context 'when info template is passed' do
      let(:subject) { described_class.new({}, :info) }

      before do
        expected_message[:attachments] = { author_icon: 'https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png', author_link: 'https://github.com/Cian911/reslacks', author_name: 'Reslacks', color: '#A0A0A0', fields: [{ short: false, title: 'Medium', value: 'Priority' }], footer: "Reslacks #0.1.0 | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}", mrkdwn: true, mrkdwn_in: ['text'], sub_field: '[Reslacks](https://github.com/Cian911/reslacks) - 0.1.0', title: 'Notification', title_link: '' }
      end

      it 'uses default info template' do
        expect(subject.message).to eq(expected_message)
      end
    end

    context 'when danger template is passed' do
      let(:subject) { described_class.new({}, :danger) }

      before do
        expected_message[:attachments] = { author_icon: 'https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png', author_link: 'https://github.com/Cian911/reslacks', author_name: 'Reslacks', color: '#990101', fields: [{ short: false, title: 'Medium', value: 'Priority' }], footer: "Reslacks #0.1.0 | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}", mrkdwn: true, mrkdwn_in: ['text'], sub_field: '[Reslacks](https://github.com/Cian911/reslacks) - 0.1.0', title: 'Notification', title_link: '' }
      end

      it 'uses default danger template' do
        expect(subject.message).to eq(expected_message)
      end
    end

    context 'when options are passed as an arg' do
      let(:subject) { described_class.new(options) }
      let(:options) do
        {
          icon_emoji: ':apple:',
          channel: '#test-channel',
          color: '#000000'
        }
      end

      before do
        expected_message[:attachments][:color] = '#000000'
        expected_message[:icon_emoji] = ':apple:'
        expected_message[:channel] = '#test-channel'
      end

      it 'overrides default values with options passed' do
        expect(subject.message).to eq(expected_message)
      end
    end
  end

  after do
    Timecop.return
  end
end
