require 'spec_helper'

describe Event do
  let(:event) { FactoryGirl.build(:event) }
  subject { event }

  it { is_expected.to validate_presence_of :location }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to validate_presence_of :start_time }
  it { is_expected.to validate_presence_of :end_time }
  it { is_expected.to validate_presence_of :event_type }
  it { is_expected.to validate_presence_of :details }
end
