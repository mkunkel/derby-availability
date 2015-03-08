include AuthenticationHelper

describe 'Events edit' do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }

  context 'confirmed and signed in' do
    before do
      confirm_and_sign_in user
      visit edit_event_path(event)
    end

    subject { page }

    it 'should not show an error' do
      expect(subject).not_to have_content('You must be logged in to do that.')
    end

    it 'should have the fields filled with correct event info' do
      expect(find_field('event[location]').value).to eql(event.location)
      expect(find_field('event[start_date]').value)
        .to eql(event.start_date.to_s)
      expect(find_field('event[end_date]').value).to eql(event.end_date.to_s)

      # These need some help
      # expect(find_field('event[start_time]').value.to_time)
      #   .to eql(event.start_time)
      # expect(find_field('event[end_time]').value).to eql(event.end_time)

      expect(find_field('event[event_type]').value).to eql(event.event_type)
      expect(find_field('event[details]').value).to eql(event.details)
    end

    it 'should change values when edited' do
      location = event.location
      event_type = event.event_type
      fill_in 'event[location]', with: event.location.reverse
      fill_in 'event[event_type]', with: event.event_type.reverse
      click_button 'Update Event'
      event.reload

      expect(event.location).to eql(location.reverse)
      expect(event.event_type).to eql(event_type.reverse)
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
