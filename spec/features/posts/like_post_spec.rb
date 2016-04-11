require 'rails_helper.rb'

feature 'Like individual post' do

  let(:user) { FactoryGirl.create(:user) }

  before do
    user.confirm
    login_as user
  end

  scenario 'can like individual post' do
    post = create(:post, caption: 'Post #1', user: user)

    visit root_path
    find(:xpath, '//a[contains(@href,"/posts/1/like")]').click
    expect(page.current_path).to eq root_path
    expect(page).to have_css '[data-icon="heart"]'
    expect(page).not_to have_css '[data-icon="heart-empty"]'
    expect(page).to have_content 'likes this'
  end
end
