require 'rails_helper.rb'

feature 'Show individual post' do

  let(:user) { FactoryGirl.create(:user) }

  before do
    user.confirm
    login_as user
  end

  scenario 'can see individual post' do
    post = create(:post, caption: 'Post #1', user: user)

    visit root_path
    first(:xpath, '//a[contains(@href,"/posts/1")]').click
    expect(page.current_path).to eq '/posts/1'
    expect(page).to have_css 'img[src*="yoda.jpg"]'
    expect(page).to have_content 'Post #1'
  end
end
