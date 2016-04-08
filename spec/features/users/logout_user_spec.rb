require 'rails_helper.rb'

feature 'User Login' do

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    user.confirm
    login_as user
  end

  it 'shows message prompting to sign in after logout' do
    visit root_path
    expect(page).to have_content 'New Post'
    expect(page).not_to have_content 'Log In'

    click_link 'Sign Out'

    expect(page).to have_css('script', text: 'You need to sign in or sign up before continuing.', visible: false)
    expect(page).to have_content 'Log In'
  end
end
