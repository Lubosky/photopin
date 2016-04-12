require 'rails_helper.rb'

feature 'Edit user profile' do

  let(:u1) { FactoryGirl.create(:user, username: 'test_user_1') }
  let(:u2) { FactoryGirl.create(:user, username: 'test_user_2') }

  before do
    u1.confirm

    post = create(:post, id: 1, caption: 'Post #1', user: u1)
    post = create(:post, id: 2, caption: 'Post #2', user: u2)

    login_as u1
    visit root_path
  end

  scenario 'when visiting user profile user can edit profiles belonging to them' do
    first(:xpath, '//a[contains(@href,"/test_user_1")]').click
    click_link 'Edit Profile'
    expect(page.current_path).to eq '/test_user_1/edit'
    attach_file('user[avatar]', 'spec/support/images/ewok.jpeg')
    click_button 'Update User'
    expect(page.current_path).to eq '/test_user_1'
    expect(page).to have_css 'img[src*="ewok.jpeg"]'
  end

  scenario 'when visiting user profile user cannot edit profiles not belonging to them' do
    first(:xpath, '//a[contains(@href,"/test_user_2")]').click
    expect(page).not_to have_content 'Edit Profile'
  end

  scenario 'user cannot navigate directly to edit another user profile' do
    visit('/test_user_2/edit')
    expect(page).not_to have_content 'Edit Profile'
    expect(page).to have_css('script', text: 'Put your hands away from this profile!', visible: false)
    expect(page.current_path).to eq root_path
  end
end
