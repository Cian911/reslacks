require 'spec_helper'

RSpec.describe Reslacks::Utils::ReslacksUtils do
  let(:subject) { described_class }

  describe '.template_exists?' do
    context 'when a class does exist' do
      let(:klass) { :danger }

      it 'returns true' do
        expect(subject.template_exists?(klass)).to be true
      end
    end
  end

  context 'when a class does not exist' do
    let(:klass) { :not_a_class }

    it 'returns false' do
      expect(subject.template_exists?(klass)).to be false
    end
  end

  context 'when checking base templates provided' do
    let(:klasses) { %i[danger info warning success] }

    it 'returns true for each base template' do
      klasses.each do |klass|
        expect(subject.template_exists?(klass)).to be true
      end
    end
  end

  describe '.include_template' do
    context 'when a valid template is available' do
      let(:template) { :danger }

      it 'returns constantized class' do
        expect(subject.include_template(template)).to be_an_instance_of(Reslacks::Templates::Danger)
      end
    end
  end
end
