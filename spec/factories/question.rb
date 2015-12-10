FactoryGirl.define do
  factory :question do
    title "My question"
    body "question body"
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end
end