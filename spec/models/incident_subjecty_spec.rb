# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IncidentSubject, type: :model do
  before(:each) do
    @incident_subject = create(:incident_subject)
  end

  it 'is valid with valid attributes' do
    expect(@incident_subject).to be_valid
  end

  it 'adds error for empty description' do
    @incident_subject.description = ''
    @incident_subject.save

    @incident_subject.valid?
    expect(@incident_subject.errors[:description][0])
      .to include('can\'t be blank')
  end
end
