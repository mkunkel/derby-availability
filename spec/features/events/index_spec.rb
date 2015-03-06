include AuthenticationHelper

describe 'Events index' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    confirm_and_sign_in user
    visit events_path
  end

  subject { page }

  it { is_expected.to have_content 'Upcoming events' }
  it { is_expected.to have_content 'No events found' }

  context 'with events' do
    before { 5.times { FactoryGirl.create(:event) } }

    it 'should show all events' do
      visit events_path
      expect(subject).to have_selector('.event', count: 5)
    end
  end
end
