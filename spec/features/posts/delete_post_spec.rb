require 'rails_helper.rb'

feature 'Delete individual post' do

  let(:user) { FactoryGirl.create(:user) }

  before do
    user.confirm
    login_as user
  end

  scenario 'can delete individual post' do
    post = create(:post, caption: 'Post #1', user: user)

    visit root_path
    find(:xpath, '//a[contains(@href,"/posts/1")]').click
    click_link 'Delete'
    expect(page).to have_css('script', text: 'Post has been successfully deleted!', visible: false)

    expect(page.current_path).to eq root_path
    expect(page).not_to have_content 'Post #1'
  end
end

