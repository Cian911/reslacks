FactoryBot.define do
  factory :option do
    color { %w[danger good warning info].sample }
    text { "#{Faker::Hipster.paragraph}" }
    username  { "#{Faker::Company.name}" }
    footer { "#{Faker::Company.catch_phrase} | #{Time.now.strftime('%A, %d %b %Y %H:%M:%S')}" }
  end
end
