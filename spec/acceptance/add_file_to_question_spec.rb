require 'rails_helper'

feature 'Add files to question' do
  given(:user) { create(:user) }

  background do
    login(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question' do
    fill_in 'Title', with: 'Test question'
    fill_in 'Text', with: 'text text'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_link 'spec_helper.rb'
  end
end