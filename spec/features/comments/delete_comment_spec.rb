require 'rails_helper.rb'

feature 'Delete comment' do

  let(:u1) { FactoryGirl.create(:user) }
  let(:u2) { FactoryGirl.create(:user) }

  before :each do
    u1.confirm
    login_as u1
    post = create(:post, id: 1, caption: 'Post #1', user: u1)
  end

  scenario 'user can delete comment if comment belongs to user' do
    comment = create(:comment, post_id: 1, content: 'This is comment #1', user: u1)
    visit root_path
    find(:xpath, '//a[contains(@href,"/posts/1/comments/1")]').click
    expect(page).not_to have_content('This is comment #1')
  end

  scenario 'user cannot delete comment if comment does not belong to user' do
    comment = create(:comment, post_id: 1, content: 'This is comment #1', user: u2)
    visit root_path
    expect(page).not_to have_css('.delete-comment')
  end
end
