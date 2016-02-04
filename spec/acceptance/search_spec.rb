require 'rails_helper'

feature 'Search' do
  given!(:question_match_body) { create(:question, title: "Question 1", body: 'abrakadabra')}
  given!(:question_match_title) { create(:question, title: "Question abrakadabra", body: 'body 123')}
  given!(:not_matched_question) { create(:question, title: "Question 3", body: 'body 123')}

  scenario 'Search for question', sphinx: true do
    build_index
    visit root_path

    fill_in 'Search', with: 'abrakadabra'
    click_on 'Search'

    expect(page).to have_content question_match_body.title
    expect(page).to have_content question_match_title.title
    expect(page).to_not have_content not_matched_question.title
  end
end