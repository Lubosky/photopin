require 'rails_helper.rb'

feature 'Create new comment' do

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    user.confirm
    login_as user
    post = create(:post, caption: 'Post #1', user: user)
  end

  scenario 'can create a post', js: true do
    visit root_path
    fill_in 'Add a comment...', with: "This is comment #1\n"
    visit root_path

    expect(page).to have_content('This is comment #1')
  end
end
