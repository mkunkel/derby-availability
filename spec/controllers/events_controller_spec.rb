require 'spec_helper'

describe EventsController do
  let(:event) { FactoryGirl.create(:event) }
  let(:valid_attributes) do
    {
      location: 'MyText',
      start_date: '2015-03-04',
      end_date: '2015-03-04',
      start_time: '2015-03-04 17:55:45',
      end_time: '2015-03-04 17:55:45',
      event_type: 'Scrimmage',
      details: 'MyText'
    }
  end
  let(:invalid_attributes) do
    {
      event_type: '',
      details: 'MyText'
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all events as @events' do
      get :index, {}, valid_session
      expect(assigns(:events)).to eq([event])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested event as @event' do
      get :show, { id: event.to_param }, valid_session
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'GET #new' do
    it 'assigns a new event as @event' do
      get :new, {}, valid_session
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested event as @event' do
      get :edit, { id: event.to_param }, valid_session
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Event' do
        expect do
          post :create, { event: valid_attributes }, valid_session
        end.to change(Event, :count).by(1)
      end

      it 'assigns a newly created event as @event' do
        post :create, { event: valid_attributes }, valid_session
        expect(assigns(:event)).to be_a(Event)
        expect(assigns(:event)).to be_persisted
      end

      it 'redirects to the created event' do
        post :create, { event: valid_attributes }, valid_session
        expect(response).to redirect_to(Event.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved event as @event' do
        post :create, { event: invalid_attributes }, valid_session
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        post :create, { event: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested event' do
        put :update,
            { id: event.to_param, event: new_attributes },
            valid_session
        event.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested event as @event' do
        put :update,
            { id: event.to_param, event: valid_attributes },
            valid_session
        expect(assigns(:event)).to eq(event)
      end

      it 'redirects to the event' do
        put :update,
            { id: event.to_param, event: valid_attributes },
            valid_session
        expect(response).to redirect_to(event)
      end
    end

    context 'with invalid params' do
      it 'assigns the event as @event' do
        put :update,
            { id: event.to_param, event: invalid_attributes },
            valid_session
        expect(assigns(:event)).to eq(event)
      end

      it "re-renders the 'edit' template" do
        put :update,
            { id: event.to_param, event: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    # event is lazy loaded, force it to be saved
    before { event }

    it 'destroys the requested event' do
      expect do
        delete :destroy, { id: event.id }, valid_session
      end.to change(Event, :count).by(-1)
    end

    it 'redirects to the events list' do
      delete :destroy, { id: event.to_param }, valid_session
      expect(response).to redirect_to(events_url)
    end
  end
end
