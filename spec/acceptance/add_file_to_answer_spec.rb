require 'rails_helper'

feature 'Add files to answer' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    Capybara.current_driver = :selenium
    login(user)
    visit question_path(question)
  end

  scenario 'User adds file when creates answer', js: true do

    fill_in 'Your answer', with: 'My answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb'
    end
  end
end