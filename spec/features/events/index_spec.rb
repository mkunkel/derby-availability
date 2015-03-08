include AuthenticationHelper

describe 'Events index' do
  let(:user) { FactoryGirl.create(:user) }

  context 'confirmed and signed in' do
    before do
      confirm_and_sign_in user
      visit events_path
    end

    subject { page }

    it { is_expected.to have_content 'Upcoming events' }
    it { is_expected.to have_content 'No events found' }

    context 'with events' do
      before do
        5.times do
          FactoryGirl.create(:event,
                             start_date: Faker::Date.forward(rand(1..30)))
        end
      end

      it 'should show all events' do
        visit events_path
        expect(subject).to have_selector('.event', count: 5)
      end

      it 'should sort events by start_date' do
        visit events_path
        dates = subject.all('.event .start_date').map { |e| e.text.to_date }
        expect(dates).to eql(dates.sort)
      end

      it 'should not show expired events' do
        FactoryGirl.create(:event, end_date: Faker::Date.backward(10))
        visit events_path
        expect(subject).to have_selector('.event', count: 5)
      end
    end
  end

  context 'not signed in' do
    before { visit events_path }

    it 'should require login' do
      expect(current_path).to eql(new_user_session_path)
    end

    it 'should tell the user they must be logged in' do
      expect(page).to have_content('You must be logged in to do that.')
    end
  end
end
