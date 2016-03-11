require 'rails_helper.rb'

feature 'List posts on index page' do
  scenario 'can see posts' do
    post1 = create(:post, caption: 'Post #1')
    post2 = create(:post, caption: 'Post #2')
    post3 = create(:post, caption: 'Post #3')

    visit '/'
    expect(page).to have_css 'img[src*="yoda.jpg"]'
    expect(page).to have_content 'Post #1'
    expect(page).to have_content 'Post #2'
    expect(page).to have_content 'Post #3'
  end
end
