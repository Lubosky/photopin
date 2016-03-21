require 'rails_helper.rb'

feature 'Edit individual post' do

  let(:user) { FactoryGirl.create(:user) }

  before do
    user.confirm
    login_as user
  end

  scenario 'can edit/update individual post' do
    post = create(:post, caption: 'Post #1', user: user)

    visit root_path
    find(:xpath, '//a[contains(@href,"/posts/1")]').click
    click_link 'Update'
    expect(page.current_path).to eq '/posts/1/edit'
    attach_file('post[image]', 'spec/support/images/ewok.jpeg')
    fill_in 'Caption', with: 'Updated post #1'
    click_button 'Update Post'
    expect(page.current_path).to eq '/posts'
    expect(page).to have_css 'img[src*="ewok.jpeg"]'
    expect(page).to have_content 'Updated post #1'
  end
end
