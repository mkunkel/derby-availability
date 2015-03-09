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

    it 'should not show an error' do
      expect(subject).not_to have_content('You must be logged in to do that.')
    end

    it { is_expected.to have_content event.location }
    it { is_expected.to have_content event.details }

    context 'joining and leaving events' do
      it 'allows a user to join an event' do
        expect(user.events.count).to eql(0)
        click_link 'Yes'

        expect(current_path).to eql(event_path(event))
        expect(user.events.count).to eql(1)
        expect(user.events_users.first.answer).to eql('Yes')
        expect(subject).to have_content('Successfully responded Yes')
      end

      it 'allows a user to decline an event' do
        expect(user.events.count).to eql(0)
        click_link 'No'

        expect(current_path).to eql(event_path(event))
        expect(user.events.count).to eql(1)
        expect(user.events_users.first.answer).to eql('No')
        expect(subject).to have_content('Successfully responded No')
      end

      it 'allows a user to be unsure about an event' do
        expect(user.events.count).to eql(0)
        click_link 'Maybe'

        expect(current_path).to eql(event_path(event))
        expect(user.events.count).to eql(1)
        expect(user.events_users.first.answer).to eql('Maybe')
        expect(subject).to have_content('Successfully responded Maybe')
      end

      it 'requires Yes, No, or Maybe' do
        expect(user.events.count).to eql(0)
        visit rsvp_event_path(event, 'event[answer]' => 'yes')

        expect(current_path).to eql(event_path(event))
        expect(user.events.count).to eql(0)
        expect(subject).to have_content('Unable to save response')
      end
    end
  end

  context 'not signed in' do
    before { visit event_path(event) }

    it 'should require login' do
      expect(current_path).to eql(new_user_session_path)
    end
  end
end
