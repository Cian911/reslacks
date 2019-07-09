require 'spec_helper'

RSpec.describe Reslacks::Format do
  let(:subject) { described_class.new(msg_format, template, options) }

  before do
    Timecop.freeze(Time.now)
  end

  describe '#formatted_msg' do
    context 'when just a basic msg_format is passed as an arg' do
      let(:msg_format) { :basic }
      let(:template) { nil }
      let(:options) { {} }
      let(:expected_msg) do
        {
          channel: '#general',
          icon_emoji: ':100:',
          text: 'This is some sample text.',
          username: 'Reslacks #0.1.0'
        }
      end

      it 'uses basic formatter options' do
        expect(subject.formatted_message).to eq(expected_msg)
      end

      context 'when no user passed args' do
        let(:msg_format) { nil }
        let(:template) { nil }
        let(:options) { {} }
        let(:expected_msg) do
          {
            channel: '#general',
            icon_emoji: ':100:',
            text: 'This is some sample text.',
            username: 'Reslacks #0.1.0'
          }
        end

        it 'uses default options' do
          expect(subject.formatted_message).to eq(expected_msg)
        end
      end
    end

    context 'when just an attachments msg_format is passed as an arg' do
      let(:msg_format) { :attachments }
      let(:template) { nil }
      let(:options) { {} }
      let(:expected_msg) do
        { attachments: { author_icon: 'https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png', author_link: 'https://github.com/Cian911/reslacks', author_name: 'Reslacks', color: '#A0A0A0', fields: [{ short: false, title: 'Medium', value: 'Priority' }], footer: "Reslacks #0.1.0 | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}", mrkdwn: true, mrkdwn_in: ['text'], sub_field: '[Reslacks](https://github.com/Cian911/reslacks) - 0.1.0',
                         title: 'Notification', title_link: '' } }
      end

      it 'uses attachments formatter options' do
        expect(subject.formatted_message).to eq(expected_msg)
      end

      context 'when valid user options are passed as args' do
        let(:options) { { color: '#00000', channel: '#random', username: 'John Doe' } }
        let(:template) { nil }
        let(:expected_msg) do
          { attachments: { author_icon: 'https://i.gyazo.com/fb68549ab4db1038cee13104e9eca8cb.png', author_link: 'https://github.com/Cian911/reslacks', author_name: 'Reslacks', channel: '#random', color: '#00000', fields: [{ short: false, title: 'Medium', value: 'Priority' }], footer: "Reslacks #0.1.0 | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}", mrkdwn: true, mrkdwn_in: ['text'], sub_field: '[Reslacks](https://github.com/Cian911/reslacks) - 0.1.0', title: 'Notification', title_link: '', username: 'John Doe' }, channel: '#random', username: 'John Doe' }
        end

        it 'uses attachments formatter options' do
          expect(subject.formatted_message).to eq(expected_msg)
        end
      end

      context 'when a template is passed as an option' do
        let(:msg_format) { :basic }
        let(:template) { :success }
        let(:options) { {} }
        let(:expected_msg) do
          {
            channel: '',
            color: '#64BF2A',
            icon_emoji: ':heavy_check_mark:',
            text: 'Reslacks test integration is working. Please override this value with your desired value.',
            username: '[Reslacks](https://github.com/Cian911/reslacks) - 0.1.0'
          }
        end

        it 'should merge success template ontop of basic formater' do
          expect(subject.formatted_message).to eq(expected_msg)
        end
      end

      context 'when template is passed with options' do
        let(:msg_format) { nil }
        let(:template) { :success }
        let(:options) { { color: '#ffffff', icon_emoji: ':not_heavy_check_mark:' } }
        let(:expected_msg) do
          {
            color: '#ffffff',
            channel: '#general',
            icon_emoji: ':not_heavy_check_mark:',
            text: 'This is some sample text.',
            username: 'Reslacks #0.1.0'
          }
        end

        it 'options should take preference over format and template' do
          expect(subject.formatted_message).to eq(expected_msg)
        end
      end
    end

    xcontext 'when just buttons msg_format is passed as an arg' do
      it 'uses buttons formatter options' do
        # Not implmented yet
      end
    end
  end

  after do
    Timecop.return
  end
end
