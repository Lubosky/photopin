require 'rails_helper.rb'

feature 'Edit individual post' do

  let(:u1) { FactoryGirl.create(:user) }
  let(:u2) { FactoryGirl.create(:user) }

  before do
    u1.confirm

    post = create(:post, id: 1, caption: 'Post #1', user: u1)
    post = create(:post, id: 2, caption: 'Post #2', user: u2)

    login_as u1
  end

  scenario 'can edit/update individual post' do
    visit root_path
    first(:xpath, '//a[contains(@href,"/posts/1")]').click
    click_link 'Edit'
    expect(page.current_path).to eq '/posts/1/edit'
    attach_file('post[image]', 'spec/support/images/ewok.jpeg')
    fill_in 'Caption', with: 'Updated post #1'
    click_button 'Update Post'
    expect(page.current_path).to eq '/posts'
    expect(page).to have_css 'img[src*="ewok.jpeg"]'
    expect(page).to have_content 'Updated post #1'
  end

  scenario 'cannot edit/update post which does not belong to him' do
    visit root_path
    first(:xpath, '//a[contains(@href,"/posts/2")]').click
    expect(page.current_path).to eq '/posts/2'
    expect(page).not_to have_content('Update')
  end

  scenario 'cannot edit/update post which does not belong to him via URL' do
    visit root_path
    visit('/posts/2/edit')
    expect(page.current_path).to eq root_path
    expect(page).to have_css('script', text: "You cannot edit a post that doesn't belong to you!", visible: false)
  end
end
