require 'rails_helper.rb'

feature 'User Login' do

  let(:user) { FactoryGirl.create(:user, username: 'test_user') }

  before :each do
    user.confirm
  end

  it 'shows success message after successful login' do
    visit root_path
    expect(page).not_to have_content 'New Post'
    expect(page).to have_content 'Log In'

    click_link 'Log In'
    fill_in 'Username', with: 'test_user'
    fill_in 'Password', with: 'abcd1234'
    click_button 'Log in'

    expect(page).to have_css('script', text: 'Signed in successfully.', visible: false)
    expect(page).to have_content 'New Post'
  end

  it 'shows alert if trying to log in with invalid credentials' do
    visit root_path

    click_link 'Log In'
    fill_in 'Username', with: 'test_user'
    fill_in 'Password', with: 'ABCD1234'
    click_button 'Log in'

    expect(page).to have_css('script', text: 'Invalid username or password.', visible: false)
    expect(page.current_path).to eq new_user_session_path
  end
end
