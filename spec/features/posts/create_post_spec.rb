require 'rails_helper.rb'

feature 'Create new post' do

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    user.confirm
    login_as user
  end

  scenario 'can create a post' do
    visit root_path
    click_link 'New Post'
    expect(page.current_path).to eq '/posts/new'
    attach_file('post[image]', 'spec/support/images/yoda.jpg')
    fill_in 'Caption', with: 'Always pass on what you have learned.'
    click_button 'Create Post'

    expect(page.current_path).to eq '/posts'
    expect(page).to have_content('Always pass on what you have learned.')
    expect(page).to have_css('img[src*="yoda"]')
  end
end
