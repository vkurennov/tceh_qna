require 'rails_helper'

feature 'Delete question' do
  given!(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Author can delete question' do
    login(user)
    visit question_path(question)

    click_on "Delete"

    expect(current_path).to eq questions_path
    expect(page).to_not have_content question.title
  end

  scenario 'Non-author can not delete question' do
    login(create(:user))
    visit question_path(question)

    expect(page).to_not have_link 'Delete'
  end

  scenario 'Unauthenticated user can not delete question' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete'
  end
end

