include AuthenticationHelper

describe 'Events index' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }

  context 'signed in' do
    before do
      confirm_and_sign_in user
      visit event_path(event)
    end

    subject { page }

    it { is_expected.to have_content event.location }
    it { is_expected.to have_content event.details }
  end

  context 'not signed in' do
    before { visit event_path(event) }

    it 'should require login' do
      expect(current_path).to eql(new_user_session_path)
    end
  end
end
