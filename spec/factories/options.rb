FactoryBot.define do
  factory :option do
    color { %w[danger good warning info].sample }
    text { Faker::Hipster.paragraph.to_s }
    username { Faker::Company.name.to_s }
    footer { "#{Faker::Company.catch_phrase} | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}" }
  end
end
