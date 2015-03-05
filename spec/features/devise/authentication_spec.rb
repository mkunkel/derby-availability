require 'spec_helper'

describe 'user authentication' do
  context 'user not signed in' do
    before { visit root_path }

    it 'should require registration from the root path' do
      expect(current_path).to eql(new_user_session_path)
      expect(page).to have_content('Log in')
    end
  end

  context 'user signed in' do
    let(:user) { FactoryGirl.create(:user) }
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
end
