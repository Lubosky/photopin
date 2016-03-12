require 'rails_helper.rb'

feature 'User registration' do

  let(:user_name) { 'test_user' }
  let(:user_email) { 'test_user@example.com' }
  let(:user_password) { 'test_password' }

  context 'with valid data' do
    before :each do
      visit new_user_registration_path
      fill_in 'Username', with: user_name
      fill_in 'Email', with: user_email
      fill_in 'Password', with: user_password, match: :first
      fill_in 'Password confirmation', with: user_password
      click_button 'Sign up'
    end

    it 'shows message about confirmation email' do
      expect(page).to have_css('script', text: 'A message with a confirmation link has been sent to your email address. Please open the link to activate your account.', visible: false)
    end

    describe 'confirmation email' do

    include EmailSpec::Helpers
    include EmailSpec::Matchers

      # Open the most recent email sent to user_email
      subject { open_email(user_email) }

      # Verify email details
      it { is_expected.to deliver_to(user_email) }
      it { is_expected.to have_body_text(/You can confirm your account/) }
      it { is_expected.to have_body_text(/users\/confirmation\?confirmation/) }
      it { is_expected.to have_subject(/Confirmation instructions/) }
    end

    context 'when clicking confirmation link in email' do
      before :each do
        open_email(user_email)
        current_email.click_link 'Confirm my account'
      end

      it 'shows confirmation message' do
        expect(page).to have_css('script', text: 'Your account was successfully confirmed.', visible: false)
      end

      it 'confirms user' do
        user = User.find_for_authentication(email: user_email)
        expect(user).to be_confirmed
      end
    end
  end

  context 'with invalid data' do

    context 'when not filling password' do
      before do
          visit new_user_registration_path
          fill_in 'Username', with: user_name
          fill_in 'Email', with: ''
          fill_in 'Password', with: user_password, match: :first
          fill_in 'Password confirmation', with: user_password
          click_button 'Sign up'
        end

      it 'shows error message' do
        expect(page).to have_content 'can\'t be blank'
      end
    end

    context 'when password is less than 8 characters long' do
      before do
          visit new_user_registration_path
          fill_in 'Username', with: user_name
          fill_in 'Email', with: user_email
          fill_in 'Password', with: '123' * 2, match: :first
          fill_in 'Password confirmation', with: '123' * 2
          click_button 'Sign up'
        end

      it 'shows error message' do
        expect(page).to have_content 'is too short (minimum is 8 characters)'
      end
    end

    context 'when username is less than 4 characters long' do
      before do
          visit new_user_registration_path
          fill_in 'Username', with: 'A' * 3
          fill_in 'Email', with: user_email
          fill_in 'Password', with: user_password, match: :first
          fill_in 'Password confirmation', with: user_password
          click_button 'Sign up'
        end

      it 'shows error message' do
        expect(page).to have_content 'is too short (minimum is 4 characters)'
      end
    end

    context 'when username is more than 18 characters long' do
      before do
          visit new_user_registration_path
          fill_in 'Username', with: 'A' * 19
          fill_in 'Email', with: user_email
          fill_in 'Password', with: user_password, match: :first
          fill_in 'Password confirmation', with: user_password
          click_button 'Sign up'
        end

      it 'shows error message' do
        expect(page).to have_content 'is too long (maximum is 18 characters)'
      end
    end

    context 'when password confirmation does not match' do
      before do
          visit new_user_registration_path
          fill_in 'Username', with: user_name
          fill_in 'Email', with: user_email
          fill_in 'Password', with: user_password, match: :first
          fill_in 'Password confirmation', with: 'abcd1234'
          click_button 'Sign up'
        end

      it 'shows error message' do
        expect(page).to have_content 'doesn\'t match Password'
      end
    end
  end

end
