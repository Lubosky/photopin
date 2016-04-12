require 'rails_helper.rb'

feature 'Show user profile' do

  let(:u1) { FactoryGirl.create(:user, username: 'test_user_1') }
  let(:u2) { FactoryGirl.create(:user, username: 'test_user_2') }

  before do
    u1.confirm

    post = create(:post, id: 1, caption: 'Post #1', user: u1)
    post = create(:post, id: 2, caption: 'Post #2', user: u2)

    login_as u1
    visit root_path
    first(:xpath, '//a[contains(@href,"/test_user_1")]').click
  end

  scenario 'when visiting a user profile, profile URL shows the username' do
    expect(page.current_path).to eq '/test_user_1'
  end

  scenario 'when visiting a user profile it shows posts belonging to specific user' do
    expect(page).to have_content 'Post #1'
    expect(page).not_to have_content 'Post #2'
  end
end
