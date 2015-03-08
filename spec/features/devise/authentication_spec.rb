include AuthenticationHelper

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

      before { register_user }
      subject { page }

      it { is_expected.to have_content confirm_msg }
    end
  end

  context 'user signed in' do
    let(:user) { FactoryGirl.create(:user) }

    context 'confirmed user' do
      before { confirm_and_sign_in user }

      it 'should redirect user to the events index from the root path' do
        expect(current_path).to eql(events_path)
      end

      it 'should not show an error' do
        expect(subject).not_to have_content('You must be logged in to do that.')
      end
    end

    context 'unconfirmed user' do
      before { sign_in user }

      it 'should redirect user to the events index from the root path' do
        expect(current_path).to eql(new_user_session_path)
      end
    end
  end
end
