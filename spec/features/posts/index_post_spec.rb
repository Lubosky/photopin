require 'rails_helper.rb'

feature 'List posts on index page' do

  let(:user) { FactoryGirl.create(:user) }

  before do
    user.confirm
    login_as user
  end

  scenario 'can see posts' do
    post1 = create(:post, caption: 'Post #1', user: user)
    post2 = create(:post, caption: 'Post #2', user: user)
    post3 = create(:post, caption: 'Post #3', user: user)

    visit '/'
    expect(page).to have_css 'img[src*="yoda.jpg"]'
    expect(page).to have_content 'Post #1'
    expect(page).to have_content 'Post #2'
    expect(page).to have_content 'Post #3'
  end
end
