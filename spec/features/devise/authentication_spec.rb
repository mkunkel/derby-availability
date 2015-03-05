require 'spec_helper'

describe 'user authentication' do
  context 'user not signed in' do
    let(:email) { Faker::Internet.email }
    before { visit root_path }

    it 'should require registration from the root path' do
      expect(current_path).to eql(new_user_session_path)
      expect(page).to have_content('Log in')
    end

    describe 'registration' do
      let(:confirm_msg) do
        'A message with a confirmation link has been sent to your email'\
        ' address. Please follow the link to activate your account.'
      end

      before do
        click_link 'Sign up'
        fill_in 'user[email]', with: email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button 'Sign up'
      end
      subject { page }

      it { is_expected.to have_content confirm_msg }
    end
  end

  context 'user signed in' do
    let(:user) { FactoryGirl.create(:user) }

    context 'confirmed user' do
      before do
        user.confirm!
        visit root_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'should redirect user to the events index from the root path' do
        expect(current_path).to eql(events_path)
      end
    end

    context 'unconfirmed user' do
      before do
        visit root_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
      end

      it 'should redirect user to the events index from the root path' do
        expect(current_path).to eql(new_user_session_path)
      end
    end
  end
end
