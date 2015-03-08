include AuthenticationHelper

describe 'Events new' do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.build(:event) }

  context 'confirmed and signed in' do
    before do
      confirm_and_sign_in user
      visit new_event_path
    end

    subject { page }

    it 'should create a new event' do
      # No reason not to expect this, but lets be sure
      expect(Event.count).to eql(0)

      fill_in 'event[location]', with: event.location
      fill_in 'event[start_date]', with: event.start_date
      fill_in 'event[end_date]', with: event.end_date
      fill_in 'event[start_time]', with: event.start_time
      fill_in 'event[end_time]', with: event.end_time
      fill_in 'event[event_type]', with: event.event_type
      fill_in 'event[details]', with: event.details
      click_button 'Create Event'

      expect(Event.count).to eql(1)
    end
  end

  context 'not signed in' do
    before { visit new_event_path }

    it 'should require login' do
      expect(current_path).to eql(new_user_session_path)
    end

    it 'should tell the user they must be logged in' do
      expect(page).to have_content('You must be logged in to do that.')
    end
  end
end
